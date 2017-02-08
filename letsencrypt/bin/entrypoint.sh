#!/bin/bash

set -e

# Validate required environment variables.
[[ -z "$DOMAINS" ]] && MISSING="$MISSING DOMAINS"
[[ -z "$EMAIL" ]] && MISSING="$MISSING EMAIL"
[[ -z "$MAILGUN_API_KEY" ]] && MISSING="$MISSING MAILGUN_API_KEY"
if [[ -n "$MISSING" ]]; then
	echo "Missing required environment variables: $MISSING" >&2
	exit 1
fi

# Wait for HAproxy to start before updating certificates on startup.
# TODO: Use Dockerize, instead of assuming it takes 60 seconds to start.
(sleep 60; first.sh) &

exec "$@"
