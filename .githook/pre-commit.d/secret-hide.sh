#!/usr/bin/env bash

# Hide all secrets.
# SEE https://git-secret.io/

git secret hide
git add "$(git secret list | sed 's/$/.secret/g')"
