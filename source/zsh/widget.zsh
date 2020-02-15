# NOTE: heavily inspired by kutsan.
# https://github.com/kutsan/dotfiles

autoload -Uz select-quoted
autoload -Uz select-bracketed

# Register functions as widgets.
foreach widget (
	select-quoted
	select-bracketed

	custom-insert-last-typed-word
	custom-tmux-copy-mode
	custom-nop
	custom-history
) {
	eval zle -N $widget
}
unset widget

# Insert last typed word for quick copy-paste.
function custom-insert-last-typed-word() {
	zle insert-last-word -- 0 -1
}

# Enable tmux copy-mode.
function custom-tmux-copy-mode() {
	if (! hash tmux &>/dev/null || [[ "$TMUX" == '' ]]) {
		return 1
	}

	tmux copy-mode
}

# Do nothing. This was introduced since unbinding keys lead to weird behavior.
function custom-nop() { }

# Since we set HIST_IGNORE_SPACE, the command will not be added to history.
function custom-history {
	zle kill-whole-line
	BUFFER=" ffh"
	zle accept-line
}
