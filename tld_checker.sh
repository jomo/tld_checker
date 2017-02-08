#!/usr/bin/env bash
# Made by jomo

if [ -z "$1" ]; then
  echo "Usage: $0 <domain-name> [DNS server]" >&2
  exit 1
fi

dns="$2"
if [ -n "$dns" ]; then
  echo "# Using DNS server '$dns'" >&2
  dns="@$dns"
fi

function check_tld {
  if [ -z "$(dig +short SOA "$1" $dns)" ]; then
    echo "$(tput setf 2)${1}$(tput sgr0)"
  else
    echo "$(tput setf 4)${1}$(tput sgr0)" >&2
  fi
}

tld_url="https://data.iana.org/TLD/tlds-alpha-by-domain.txt"
echo "# Downloading TLD list from $tld_url ..." >&2
tlds="$(curl --progress-bar "$tld_url" | grep -v "^#")" || (echo "Error while downloading TLDs." && exit 1)
count="$(echo "$tlds" | wc -l)"

echo "# Getting available '$1' domains for $count TLDs ..." >&2

workers=32
for i in $(seq $((workers-1)) 0); do
  for tld in $(echo "$tlds" | awk "(NR+$i) % $workers == 0"); do
    check_tld "${1}.${tld}"
  done &
done

# Wait for everything to be done
wait
echo "# done" >&2