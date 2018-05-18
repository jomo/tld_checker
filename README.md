# TLD checker
Check domain name for availability on every Top-Level-Domain.

[![asciicast](asciicast.svg)](https://asciinema.org/a/24219)

green means domain available :+1:  
red means domain not available :-1:

This downloads a [list of TLDs](https://data.iana.org/TLD/tlds-alpha-by-domain.txt) from IANA, so it should always be up to date.

**Note**: A domain will be reported as available when your (specified) DNS server states that the domain does not exist
([NXDOMAIN](https://tools.ietf.org/html/rfc2308#section-2.1)). A domain will also be reported as not available when the DNS server times out.

## Usage

```bash
./tld_checker.sh <domain> [DNS server]
```

## Examples
Check domain availability:
```bash
./tld_checker.sh doge
```

Write _only_ available domains to file:
```bash
./tld_checker.sh doge | tee available.txt
```
