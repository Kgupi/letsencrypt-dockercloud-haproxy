#!/bin/bash

# See: https://github.com/tartley/rerun2

set -e

mkdir -p "$NOTIFICATION_FOLDER"

# Abort, if already running.
if [[ -n "$(ps | grep inotifywait | grep -v grep)" ]]; then
	echo "Already watching directory: $NOTIFICATION_FOLDER" >&2
	exit 1
fi

# Watch a directory. When changes are detected, install
# combined certificates and reload HAproxy.
echo "Watching directory: $NOTIFICATION_FOLDER"
inotifywait \
	--event create \
	--event delete \
	--event modify \
	--event move \
	--format "%e %w%f" \
	--monitor \
	--quiet \
	--recursive \
	"$NOTIFICATION_FOLDER" |
while read CHANGED
do
	echo "$CHANGED"
	(install-certs.sh; /reload.sh) &
done
