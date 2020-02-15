# NOTE: Inspired by https://github.com/kutsan/dotfiles.

################################################################################
# BASIC                                                                        #
################################################################################

# Enable Vim keybindings.
# https://superuser.com/a/648046
bindkey -v
export KEYTIMEOUT=1
bindkey -M vicmd '^[' custom-nop
bindkey -M viins '^X' custom-nop

################################################################################
# INSERT                                                                       #
################################################################################

# Move up or to the previous match.
bindkey -M viins '^[k' up-line-or-beginning-search

# Move down or to the next match.
bindkey -M viins '^[j' down-line-or-beginning-search

# Delete a single character.
bindkey -M viins '^[h' backward-delete-char

# Go forward char or complete current completion (autosuggest-accept).
bindkey -M viins '^[l' vi-forward-char

# Execute the current autosuggestion with <A-CR>.
bindkey -M viins '^[^M' autosuggest-execute

# Enable tmux copy mode.
bindkey -M viins '^F' custom-tmux-copy-mode
bindkey -M viins '^B' custom-tmux-copy-mode

# Allow to erase characters non-vi style.
bindkey -M viins '^?' backward-delete-char

# Delete a whole word backwards.
bindkey -M viins '^X' backward-kill-word

# Delete the line up to the cursor.
bindkey -M viins '^U' backward-kill-line

# Insert last typed word.
bindkey -M viins '^Y' custom-insert-last-typed-word

# Search the history.
bindkey -M viins '^R' custom-history

################################################################################
# COMMAND                                                                      #
################################################################################

# Alt-k moves to previous command.
bindkey -M vicmd '^[k' up-history

# Alt-j moves to next command.
bindkey -M vicmd '^[j' down-history

# Go beginning of line.
bindkey -M vicmd 'H' vi-beginning-of-line

# Go end of line.
bindkey -M vicmd 'L' vi-end-of-line

# Enable tmux copy mode.
bindkey -M vicmd '^F' custom-tmux-copy-mode
bindkey -M vicmd '^B' custom-tmux-copy-mode

################################################################################
# VISUAL                                                                       #
################################################################################

# Go beginning of line.
bindkey -M visual 'H' vi-beginning-of-line

# Go end of line.
bindkey -M visual 'L' vi-end-of-line

# Text objects for delimiters.
foreach char ({a,i}{\',\",\`}) { bindkey -M visual $char select-quoted } && unset char

# Text objects for pairs of brackets.
foreach char ({a,i}${(s..)^:-'()[]{}<>bB'}) { bindkey -M visual $char select-bracketed } && unset char

################################################################################
# COMPLETION                                                                   #
################################################################################

# Traverse completion menu in reverse.
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Navigate completion up.
bindkey -M menuselect 'k' vi-up-line-or-history

# Navigate completion down.
bindkey -M menuselect 'j' vi-down-line-or-history

# Navigate completion left.
bindkey -M menuselect 'h' vi-backward-char

# Navigate completion right.
bindkey -M menuselect 'l' vi-forward-char
