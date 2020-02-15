#!/usr/bin/env sh

# https://unix.stackexchange.com/a/350847

tmux -f /dev/null -L temp start-server \; list-keys | \
	sed -r \
	-e "s/(bind-key.*\s+)([\"#~\$])(\s+)/\1\'\2\'\3/g" \
	-e "s/(bind-key.*\s+)([\'])(\s+)/\1\"\2\"\3/g" \
	-e "s/(bind-key.*\s+)([;])(\s+)/\1\\\\\2\3/g" \
	-e "s/(command-prompt -I )#([SW])/\1\"#\2\"/g" \
	-e "s/(if-shell -F -t = )#([^ ]+)/\1\"#\2\"/g" \
	> /tmp/tmux-reset.conf

tmux unbind-key -a
tmux source-file /tmp/tmux-reset.conf
tmux source-file ~/.config/tmux/config
