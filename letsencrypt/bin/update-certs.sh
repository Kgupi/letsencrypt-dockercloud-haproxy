#!/bin/bash

source /opt/letsencrypt/bin/util.sh

OUTPUT="$(/usr/bin/certbot renew)"

if [[ $? -eq 0 ]]; then
	echo "${OUTPUT}" | grep -q "No renewals were attempted"
	if [[ $? -eq 0 ]]; then
		echo "all certificates have more than 30 days left - nothing to do "
		exit 0
	fi
	MSG="success"
    CODE=0
else
    MSG="failed"
    CODE=1
fi

util::send "${DOMAINS}: Let's Encrypt keys renewal ${MSG}!: ${OUTPUT}"
exit $CODE
