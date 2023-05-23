#!/bin/sh

# create a temporary file to hold the selected file path(s)
readonly TEMP_FILE=$(mktemp)
trap 'rm -f "$TEMP_FILE"' EXIT

if [ -s "$kak_buflist" ]; then
	# sk --color light "$@" <"$kak_buflist" >"$TEMP_FILE"
	fzf --color light "$@" <"$kak_buflist" >"$TEMP_FILE"
	rm -f "$kak_buflist"
	command="buffer"
else
	# sk --color light "$@" >"$TEMP_FILE"
	fd --type f --hidden --exclude /.git/ --color never | fzf --color light "$@" >"$TEMP_FILE"
	command="edit"
fi

if [ -s "$TEMP_FILE" ]; then
	# the logical OR deals with a lacking final newline character
	while IFS= read -r line || [ -n "$line" ]; do
		printf 'evaluate-commands -client "%s" "%s" "%s"\n' "$kak_client" "$command" "$line" | kak -p "$kak_session"
	done <"$TEMP_FILE"
fi
