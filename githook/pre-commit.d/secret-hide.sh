#!/usr/bin/env bash

# Hide all secrets.
# SEE https://git-secret.io/

for f in $(git secret list | sed 's/$/.secret/g'); do
	git secret changes "$f" | grep '+++'

	if [ "$?" -eq 0 ]; then
		printf "%s\n" "Hiding secret $f."
		git secret hide "$f"
		git add "$f"
	fi
done
