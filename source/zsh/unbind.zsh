# Unbind movement keys, arrow keys and function keys.

foreach mode (
	viins
	vicmd
	visual
) {
	foreach key (
		'^K'
		'^J'
		'^H'
		# '^L' # Clears screen by default.
		'^[[B' # <Down>
		'^[[A' # <Up>
		'^[[D' # <Left>
		'^[[C' # <Right>
		'^[OP' # <F1>
		'^[OQ' # <F2>
		'^[OR' # <F3>
		'^[OS' # <F4>
		'^[[15~' # <F5>
		'^[[17~' # <F6>
		'^[[18~' # <F7>
		'^[[19~' # <F8>
		'^[[20~' # <F9>
		'^[[21~' # <F10>
		'^[[23~' # <F11>
		'^[[24~' # <F12>
	) {
		bindkey -M "$mode" "$key" custom-nop
	}
}

unset key
unset mode
