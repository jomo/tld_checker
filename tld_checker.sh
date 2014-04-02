#!/bin/bash
# tld_checker.sh
# Made by jomo

if [ -z "$1" ]; then
  echo "Usage: $0 <domain-name> [DNS server]" >&2
  exit 1
fi
if [ ! -z "$2" ]; then
  echo "# Using DNS server '$2'" 2>&2
fi
tld_url="https://data.iana.org/TLD/tlds-alpha-by-domain.txt"
echo "# Downloading TLD list from $tld_url ..." >&2
tlds="$(curl --progress-bar "$tld_url" | grep -v "^#")" || (echo "Error while downloading TLDs." && exit 1)
count="$(echo "$tlds" | wc -l)"
export tld_tmpfile="/tmp/tld_counter"

trap "echo exit; rm -f "$tld_tmpfile"; exit" SIGINT SIGTERM # break out of loop
echo -n > "$tld_tmpfile"
echo "# Getting available '$1' domains for $count TLDs ..." >&2
for tld in $(echo $tlds); do
  (domain="${1}.${tld}"
  if (host "$domain" $2 | grep -q "3(NXDOMAIN)"); then
    echo "$(tput setf 2)${domain}$(tput sgr0)"
  else
    echo "$(tput setf 4)${domain}$(tput sgr0)" >&2
  fi
  echo -n "." >> "$tld_tmpfile") &
done

while [ "$(wc -m $tld_tmpfile | cut -d " " -f 1)" -lt "$count" ]; do
  sleep 0.1
done
rm -f "$tld_tmpfile"
echo "# done" >&2
