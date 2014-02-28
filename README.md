# TLD checker
Check a domain for availability on every Top-Level-Domain.

![terminal-screenshot](http://i.imgur.com/L2G5POX.png)

This downloads a [list of TLDs](https://data.iana.org/TLD/tlds-alpha-by-domain.txt) from IANA, so it should always be up to date :+1:.

Note: This will report a domain as available when your (specified) DNS server reports that the domain does not exist
([NXDOMAIN](https://tools.ietf.org/html/rfc2308#section-2.1)).


## Usage

```bash
./tld_checker.sh <domain> [DNS server]
```

Available domains will be _green_ and go to stdout.<br>
Non-available domains will be _red_ and go to stderr.

## Examples
Check domain availability:
```bash
./tld_checker.sh doge
```

Write only available domains to file:
```bash
./tld_checker.sh doge > available.txt &2>/dev/null
```
