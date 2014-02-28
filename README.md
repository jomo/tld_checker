# TLD checker
check all Top-Level-Domains for specific domain availability

![terminal-screenshot](http://i.imgur.com/L2G5POX.png)

## Usage

```
./tld\_checker \<domain\> [DNS server]
```

available domains will be green on stdout, non-available domains will be red on stderr

## Examples
Check a domain

```
./tld\_checker doge
```

Write available domains to file
(`&2/dev/null` is used to _not_ print non-available domains)

```
./tld\_checker doge > available.txt &2>/dev/null
```
