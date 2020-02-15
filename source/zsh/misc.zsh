################################################################################
# HISTORY                                                                      #
################################################################################

# Set history location and size.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=8192
SAVEHIST=4096

# Share history between all sessions.
setopt SHARE_HISTORY

# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST

# Don't display a line previously found.
setopt HIST_FIND_NO_DUPS

# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS

# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS

# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE

# Remove superfluous blanks before recording an entry.
setopt HIST_REDUCE_BLANKS

# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Do not beep when accessing history.
setopt NO_HIST_BEEP

################################################################################
# NAVIGATION                                                                   #
################################################################################

# The maximum size of the directory stack for `pushd` and `popd`.
DIRSTACKSIZE=16

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD

# Don't push multiple copies of the same directory onto the stack.
setopt PUSHD_IGNORE_DUPS

################################################################################
# SEARCH                                                                       #
################################################################################

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

################################################################################
# OTHER                                                                        #
################################################################################

# Load colors explicitly.
autoload -Uz colors && colors

# Edit command line with an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '' edit-command-line

# Custom time command output format (bash-like).
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

# Allow comments even in interactive shells.
setopt INTERACTIVE_COMMENTS

# Do not beep when autocompleting.
setopt NO_LIST_BEEP

# Convenient file moving.
autoload -Uz zmv

# Tiny terminal calculator.
#autoload -Uz zcalc

# Filetype awareness. Disabled because really slow.
#autoload -Uz zsh-mime-setup && zsh-mime-setup

# Add sudo to command using A-s.
zsh_insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N zsh_insert-sudo zsh_insert_sudo
bindkey "^[s" zsh_insert-sudo
