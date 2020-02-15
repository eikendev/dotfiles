#!/usr/bin/env bash

onedark_black="#282c34"
onedark_white="#abb2bf"
onedark_red="#e06c75"
onedark_dark_red="#be5046"
onedark_green="#98c379"
onedark_yellow="#e5c07b"
onedark_dark_yellow="#d19a66"
onedark_blue="#61afef"
onedark_magenta="#c678dd"
onedark_cyan="#56b6c2"
onedark_gutter_grey="#4b5263"
onedark_comment_grey="#5c6370"

__get_tmux() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

__set_tmux() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

__set_tmuxw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

__set_tmux "status-justify" "left"

__set_tmux "status-left-length" "100"
__set_tmux "status-right-length" "100"
__set_tmux "status-right-attr" "none"

__set_tmux "status-attr" "none"
__set_tmux "status-left-attr" "none"

__set_tmux "pane-border-fg" "$onedark_white"
__set_tmux "pane-active-border-fg" "$onedark_white"

__set_tmux "display-panes-active-colour" "$onedark_yellow"
__set_tmux "display-panes-colour" "$onedark_blue"

__set_tmux "status-bg" "$onedark_black"
__set_tmux "status-fg" "$onedark_white"

status_widgets=$(__get_tmux "@onedark_widgets" "")
time_format=$(__get_tmux "@onedark_time_format" "%H:%M")
date_format=$(__get_tmux "@onedark_date_format" "%Y-%m-%d")

__set_tmux "status-left" "#[fg=$onedark_black,bold]#{?client_prefix,#[bg=$onedark_blue],#{?pane_in_mode,#[bg=$onedark_yellow],#[bg=$onedark_green]}} #S "
__set_tmux "status-right" "#{?window_zoomed_flag,[+],}#[bg=$onedark_black,nounderscore,noitalics]#{?client_prefix,#[fg=$onedark_blue],#{?pane_in_mode,#[fg=$onedark_yellow],#[fg=$onedark_green]}} ${date_format} ${time_format} #[fg=$onedark_white,bg=$onedark_gutter_grey] ${status_widgets} #[fg=$onedark_black,bold]#{?client_prefix,#[bg=$onedark_blue],#{?pane_in_mode,#[bg=$onedark_yellow],#[bg=$onedark_green]}} #h "
__set_tmux "window-status-format" "#[fg=$onedark_white,bg=$onedark_black] #I #W "
__set_tmux "window-status-current-format" "#[fg=$onedark_white,bg=$onedark_gutter_grey,nobold] #I #W "

__set_tmuxw "window-status-fg" "$onedark_black"
__set_tmuxw "window-status-bg" "$onedark_black"
__set_tmuxw "window-status-attr" "none"

__set_tmuxw "window-status-activity-bg" "$onedark_black"
__set_tmuxw "window-status-activity-fg" "$onedark_black"
__set_tmuxw "window-status-activity-attr" "none"

__set_tmuxw "window-status-separator" ""

# Change the color of window list.
__set_tmuxw "mode-style" "fg=$onedark_black,bg=$onedark_yellow"

# Change the color of command line (what is message-command-style for?).
__set_tmuxw "message-style" "fg=$onedark_black,bg=$onedark_yellow"
__set_tmuxw "message-command-style" "fg=$onedark_yellow,bg=$onedark_black"
