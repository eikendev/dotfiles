################################################################################
# BASIC                                                                        #
################################################################################

# Change the prefix key.
set-option -g prefix C-a

# Press double prefix to propagate through tmux.
bind-key C-a send-prefix

# Reload the configuration.
bind-key r source-file ~/.config/tmux/config \; display-message "Reload done."

# Reload the configuration (and reset bindings).
bind-key R run-shell ~/.config/tmux/script/reset.sh \; display-message "Reset done."

# Unbind movement keys by default.
unbind-key j
unbind-key k
unbind-key h
unbind-key l

################################################################################
# VIEW                                                                         #
################################################################################

# Use C-Space to toggle status bar.
bind-key Space set-option status

# Analogous with the clearing of the shell.
bind-key L clear-history

# Zoom into active pane.
bind-key -n F2 resize-pane -Z

################################################################################
# WINDOW                                                                       #
################################################################################

# Create a new window like a tab.
# Start shell in current directory.
unbind-key c
bind-key -n C-t new-window   -c "#{pane_current_path}"
bind-key %   split-window -h -c "#{pane_current_path}"
bind-key '"' split-window -v -c "#{pane_current_path}"

# More intuitive window split keys.
#bind-key | split-window -h -c "#{pane_current_path}"
#bind-key - split-window -v -c "#{pane_current_path}"

# Switch windows vim-style.
unbind-key n
bind-key j next-window
unbind-key p
bind-key k previous-window

# Switch back to the last window.
bind-key u last-window

# Swap windows across themselves.
bind-key -r '<' swap-window -t -1
bind-key -r '>' swap-window -t +1

################################################################################
# PANE                                                                         #
################################################################################

# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind-key -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind-key -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind-key -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
bind-key -T copy-mode-vi C-j select-pane -D
bind-key -T copy-mode-vi C-k select-pane -U
bind-key -T copy-mode-vi C-h select-pane -L
bind-key -T copy-mode-vi C-l select-pane -R

# Propagate previously bound keys through.
bind-key C-j send-keys 'C-j'
bind-key C-k send-keys 'C-k'
bind-key C-h send-keys 'C-h'
bind-key C-l send-keys 'C-l'

# Switch panes vim-style.
# NOTE: Disabled because using smart pane switching instead.
#bind-key h select-pane -L
#bind-key j select-pane -D
#bind-key k select-pane -U
#bind-key l select-pane -R

# Go back to the last pane.
bind-key '#' last-pane

# Toggle between two panes.
bind-key -n F3 run-shell "~/.config/tmux/script/toggle-pane.zsh"

################################################################################
# COPY AND PASTE                                                               #
################################################################################

# Act like Vim.
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi "v" send -X begin-selection
bind-key -T copy-mode-vi "V" send -X select-line
bind-key -T copy-mode-vi "C-v" send -X rectangle-toggle \; send -X begin-selection
bind-key -T copy-mode-vi "y" send -X copy-selection-and-cancel

# Enter copy mode easily.
bind-key a copy-mode

# Paste from system clipboard.
bind-key p run "xclip -o -sel clip | tmux load-buffer - ; tmux paste-buffer"

# Paste without CR feed.
bind-key P run "xclip -o -sel clip | tmux load-buffer - ; tmux paste-buffer -s ''"

################################################################################
# SEARCH                                                                       #
################################################################################

# Jump to search mode directly.
bind-key / copy-mode \; send-keys '/'
bind-key ? copy-mode \; send-keys '?'

# Enable incremental search.
bind-key -T copy-mode-vi / command-prompt -i -p '/' 'send-keys -X search-forward-incremental "%%%"'
bind-key -T copy-mode-vi ? command-prompt -i -p '?' 'send-keys -X search-backward-incremental "%%%"'
