#!/bin/bash
# tld_checker.sh
# Made by JonApps

if [ -z "$1" ]; then
  echo "Usage: $0 <domain-name> [DNS server]" >&2
  exit 1
fi
if [ ! -z "$2" ]; then
  echo "#Using DNS server '$2'" 2>&2
fi
tld_url="https://data.iana.org/TLD/tlds-alpha-by-domain.txt"
tlds="$(curl "$tld_url" 2>/dev/null | grep -v "^#" || (echo "Error while downloading TLDs." && exit 1))"
count="$(echo "$tlds" | wc -l)"

trap exit SIGINT SIGTERM # break out of loop

echo "#Listing available '$1' domains for $count TLDs" >&2
for tld in $(echo $tlds); do
  domain="${1}.${tld}"
  if (host "$domain" $2 | grep -q "NXDOMAIN"); then
    tput setf 2
    echo "$domain"
  else
    tput setf 4
    echo "$domain" >&2
  fi
  tput sgr0
done
echo "#done" >&2
