#!/usr/bin/env bash

# Hide all secrets.
# SEE https://git-secret.io/

printf "%s\n" "Hiding secrets..."
git secret hide

for f in $(git secret list); do
	printf "%s\n" "Adding secret $f..."
	git add "$f.secret"
done
