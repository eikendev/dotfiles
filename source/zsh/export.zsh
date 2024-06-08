# NOTE: We do not set PATH in this file intentionally.
# https://www.zsh.org/mla/users/2003/msg00512.html

# Set locale information.
export LANG='en_US.UTF-8'
export LANGUAGE='en_US'
export LC_MEASUREMENT='de_DE.UTF-8'
export LC_MONETARY='de_DE.UTF-8'
export LC_TIME='en_GB.UTF-8'

# Explicitly set custom locations for user-specific cache, configuration files, and data.
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Set the default browser.
#export BROWSER='firefox'

# Set the default desktop wallpaper.
export WALLPAPER='/usr/share/backgrounds/default.png'

# Let git ask for password in CLI.
export GIT_ASKPASS=

# Allow for relocation of git root.
export GIT_ROOT="$HOME/git"

# Color support and case-insensitive search in less.
export LESS="\
	--ignore-case \
	--tilde \
	--jump-target=8 \
	--RAW-CONTROL-CHARS \
	--clear-screen \
	--silent \
	--tabs=4 \
	--shift=5 \
"

# Do not write history file for less.
export LESSHISTFILE='/dev/null'

# Reference the dotfiles directory.
export DOTFILES="$HOME/.dotfiles"

# Disable telemetry for Microsoft's dotnet.
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Tell fzf its default setup.
export FZF_DEFAULT_OPTS="
	--no-mouse \
	--preview-window='right:60%' \
	--bind='alt-enter:accept' \
	--bind='alt-k:up' \
	--bind='alt-j:down' \
	--bind='ctrl-f:page-down' \
	--bind='ctrl-b:page-up' \
	--bind='ctrl-d:cancel' \
	--bind='?:toggle-preview' \
"

# Tell python to read a startup file.
export PYTHONSTARTUP="$HOME/.config/python/startup"

# Define zsh configuration directory for convenience.
export ZSH_CONFIG="$HOME/.config/zsh"

# Use KDE file picker in Firefox.
#export XDG_CURRENT_DESKTOP=KDE
#export GTK_USE_PORTAL=1

# Use nvim if available.
# https://unix.stackexchange.com/a/4861
if [ -x "$(command -v nvim)" ]; then
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi

export HACKENV_MEMORY='4194304'

# Set configuration paths for different applications.
export BAT_CONFIG_PATH="$HOME/.config/bat/batrc"
export CARGO_HOME="$HOME/.config/cargo"
export GOPATH="$HOME/.local/share/go"
export DOCKER_CONFIG="$HOME/.config/docker"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export RUSTUP_HOME="$HOME/.local/share/rustup"
