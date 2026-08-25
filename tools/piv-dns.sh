#!/bin/bash

## Uncomment just one domain to test against
# domain=kennethho.ca
domain=stg.kennethho.ca

sep="────────────────────────────────────────"

echo ""
echo "  DNS Check: $domain"
echo "  $(date)"
echo ""

echo "$sep"
echo "▸ A record — $domain"
echo ""
dig $domain +noall +answer -t A
echo ""

echo "$sep"
echo "▸ AAAA record — $domain"
echo ""
dig $domain +noall +answer -t AAAA
echo ""

echo "$sep"
echo "▸ A record — www.$domain"
echo ""
dig www.$domain +noall +answer -t A
echo ""

echo "$sep"
echo "▸ AAAA record — www.$domain"
echo ""
dig www.$domain +noall +answer -t AAAA
echo ""

echo "$sep"
echo "▸ Host lookup — $domain"
echo ""
host -v $domain
echo ""

echo "$sep"
echo "▸ Host lookup — www.$domain"
echo ""
host -v www.$domain
echo ""

echo "$sep"
echo "▸ DNSSEC (via 1.1.1.1) — $domain"
echo ""
dig @1.1.1.1 $domain DNSKEY +dnssec +multiline
echo ""