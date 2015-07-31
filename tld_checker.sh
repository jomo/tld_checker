#!/usr/bin/env bash
# Made by jomo

if [ -z "$1" ]; then
  echo "Usage: $0 <domain-name> [DNS server]" >&2
  exit 1
fi

dns="$2"
if [ -n "$dns" ]; then
  echo "# Using DNS server '$dns'" >&2
fi

function check_tld {
  if (host "$1" $dns | fgrep -q "3(NXDOMAIN)"); then
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
for tld in $tlds; do
  check_tld "${1}.${tld}" &
  sleep 0.005
done

# Wait for everything to be done
while fg 2>/dev/null; do
  true
done

sleep 1 # idk why this is required, but it is.
echo "# done" >&2