#!/bin/bash
domain=kennethho.ca

dig $domain +noall +answer -t A

dig $domain +noall +answer -t AAAA

dig www.$domain +noall +answer -t A

dig www.$domain +noall +answer -t AAAA

host -v $domain

host -v www.$domain
