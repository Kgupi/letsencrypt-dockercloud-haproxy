#!/bin/bash

util::send() {
	curl -s --user "api:$MAILGUN_API_KEY" \
		https://api.mailgun.net/v3/sandbox464b56c1e6a64e35a397e37669a27499.mailgun.org/messages \
		-F from="Let's Encrypt Renew Service <mailgun@sandbox464b56c1e6a64e35a397e37669a27499.mailgun.org>" \
		-F to="${EMAIL}" \
		-F subject="Let's Encrypt Renew Status" \
		-F text="$1"
}
