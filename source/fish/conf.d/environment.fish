# Set locale information.
set -gx LANG 'en_US.UTF-8'
set -gx LANGUAGE 'en_US'
set -gx LC_MEASUREMENT 'de_DE.UTF-8'
set -gx LC_MONETARY 'de_DE.UTF-8'
set -gx LC_TIME 'en_GB.UTF-8'

# Explicitly set custom locations for user-specific cache, configuration files, and data.
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

# Set the default desktop wallpaper.
set -gx WALLPAPER '/usr/share/backgrounds/default.png'

# Color support and case-insensitive search in less.
set -gx LESS "--ignore-case --tilde --jump-target=8 --RAW-CONTROL-CHARS --clear-screen --silent --tabs=4 --shift=5"

# Do not write history file for less.
set -gx LESSHISTFILE '/dev/null'

# Reference the dotfiles directory.
set -gx DOTFILES "$HOME/.dotfiles"

# Disable telemetry for Microsoft's dotnet.
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

# Tell fzf its default setup.
set -gx FZF_DEFAULT_OPTS "--no-mouse --preview-window='right:60%' --bind='alt-enter:accept' --bind='alt-k:up' --bind='alt-j:down' --bind='ctrl-f:page-down' --bind='ctrl-b:page-up' --bind='ctrl-d:cancel' --bind='?:toggle-preview'"

# Tell python to read a startup file.
set -gx PYTHONSTARTUP "$HOME/.config/python/startup"

# Use nvim if available.
if command -v nvim > /dev/null
    set -gx EDITOR 'nvim'
    set -gx VISUAL 'nvim'
else
    set -gx EDITOR 'vim'
    set -gx VISUAL 'vim'
end

set -gx HACKENV_MEMORY '4194304'

# Set configuration paths for different applications.
set -gx BAT_CONFIG_PATH "$HOME/.config/bat/batrc"
set -gx CARGO_HOME "$HOME/.config/cargo"
set -gx GOPATH "$HOME/.local/share/go"
set -gx DOCKER_CONFIG "$HOME/.config/docker"
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/ripgreprc"
set -gx RUSTUP_HOME "$HOME/.local/share/rustup"
