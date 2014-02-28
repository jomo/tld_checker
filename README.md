# TLD checker
Check domain name for availability on every Top-Level-Domain.

![terminal-screenshot](http://i.imgur.com/L2G5POX.png)<br>
green means available domain :+1:<br>
red means non-available domain :-1:

This downloads a [list of TLDs](https://data.iana.org/TLD/tlds-alpha-by-domain.txt) from IANA, so it should always be up to date.

**Note**: A domain will be reported as available when your (specified) DNS server states that the domain does not exist
([NXDOMAIN](https://tools.ietf.org/html/rfc2308#section-2.1)). A domain will also be reported as non-available when the server times out.


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
./tld_checker.sh doge > available.txt 2>/dev/null
```
