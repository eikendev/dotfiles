# https://unix.stackexchange.com/a/390523

function clip-wrap-widgets() {
	# Assume we are the first wrapper and that we only wrap native widgets.
	# See zsh-autosuggestions.zsh for a more generic and more robust wrapper.
	local copy_or_paste=$1
	shift

	for widget in $@; do
		if [[ $copy_or_paste == "copy" ]]; then
			eval "
			function _clip-wrapped-$widget() {
				zle .$widget
				xclip -in -selection clipboard <<<\$CUTBUFFER
			}
			"
		else
			eval "
			function _clip-wrapped-$widget() {
				CUTBUFFER=\$(xclip -out -selection clipboard)
				zle .$widget
			}
			"
		fi

		zle -N $widget _clip-wrapped-$widget
	done
}

local copy_widgets=(
	vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
	vi-put-{before,after}
)

# Can at the moment only wrap native widgets.
clip-wrap-widgets copy $copy_widgets
clip-wrap-widgets paste  $paste_widgets
