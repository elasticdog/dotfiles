#!/bin/sh

# create a temporary file to hold the selected file path(s)
readonly TEMP_FILE=$(mktemp)
trap 'rm -f "$TEMP_FILE"' EXIT

lf -command="map <enter> :open" -selection-path="$TEMP_FILE" "$@"

if [ -s "$TEMP_FILE" ]; then
	# the logical OR deals with a lacking final newline character
	while IFS= read -r line || [ -n "$line" ]; do
		printf 'evaluate-commands -client "%s" edit "%s"\n' "$kak_client" "$line" | kak -p "$kak_session"
	done <"$TEMP_FILE"
fi
