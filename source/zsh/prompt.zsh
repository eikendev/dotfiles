# Inspired by anishathalye.
# SEE: https://www.anishathalye.com/2015/02/07/an-asynchronous-shell-prompt/

autoload -Uz add-zsh-hook

function +vi-git-untracked() {
	emulate -L zsh
	if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
		hook_com[unstaged]+="%F{222}+%f"
	fi
}

function _prompt_turs_prompt() {
	PROMPT=`turs prompt -k "$KEYMAP" -r "$?"`
}

function _prompt_turs_rprompt() {
	turs rprompt
}

ASYNC_PROC=0
function TRAPUSR1() {
	RPROMPT="$(cat ${XDG_CACHE_HOME:-$HOME/.cache}/turs/$$)"
	ASYNC_PROC=0
	zle && zle reset-prompt
}

function _prompt_turs_precmd() {
	turs precmd

	function async() {
		local turs_cache="${XDG_CACHE_HOME:-$HOME/.cache}/turs"
		mkdir -p "$turs_cache"
		find "$turs_cache" -type f -mmin +60 -delete
		printf "%s" "$(_prompt_turs_rprompt)" > "$turs_cache/$$"
		kill -s USR1 $$
	}

	if [[ "${ASYNC_PROC}" != 0 ]]; then
		kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
	fi

	async &!
	ASYNC_PROC=$!
}

function zle-line-init zle-keymap-select {
	_prompt_turs_prompt
	zle reset-prompt
}

if [ -x "$(command -v turs)" ]; then
	zle -N zle-line-init
	zle -N zle-keymap-select

	add-zsh-hook precmd _prompt_turs_precmd
else
	autoload -Uz promptinit && promptinit

	setopt PROMPT_SUBST

	autoload -Uz vcs_info
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' use-simple true
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' check-for-staged-changes true
	zstyle ':vcs_info:*' stagedstr "%F{150}●%f"
	zstyle ':vcs_info:*' unstagedstr "%F{222}●%f"
	zstyle ':vcs_info:git+set-message:*' hooks git-untracked
	zstyle ':vcs_info:git*' formats "[%b %F{150}✔%f%c%u]"
	zstyle ':vcs_info:git*' actionformats "[%b %F{167}✘%f%c%u]"

	PROMPT='%n@%m:%~%(?..%F{167})$%f '
	RPROMPT="\${vcs_info_msg_0_}"

	# vcs_info called before prompt is drawn.
	add-zsh-hook precmd vcs_info
fi
