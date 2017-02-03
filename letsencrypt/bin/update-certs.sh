#!/bin/bash

source ./util.sh

OUTPUT="$(certbot renew)"

if [[ $? -eq 0 ]]; then
	echo "${OUTPUT}" | grep -q "No renewals were attempted"
	if [[ $? -eq 0 ]]; then
		# all certificates have more than 30 days left -
		# nothing to do
		exit 0
	fi
	echo "${OUTPUT}" | tr -Cd '[:print:]\n' \
		| util::send "${DOMAINS}: Let's Encrypt keys renewal success"
else
	echo "${OUTPUT}" | tr -Cd '[:print:]\n' \
		| util::send "${DOMAINS}: Let's Encrypt keys renewal failed, exit code $?!"
	exit 1
fi
