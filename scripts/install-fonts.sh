#!/usr/bin/env bash

set -e

# Enable globstar for recursive globbing
shopt -s globstar

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

FONT_DIR="$XDG_DATA_HOME/fonts"

FIRACODE_REPO='tonsky/FiraCode'
MONASPACE_REPO='githubnext/monaspace'
SOURCE_CODE_PRO_REPO='adobe-fonts/source-code-pro'

NERD_FONTS_ZIP='NerdFontsSymbolsOnly.zip'
NERD_FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$NERD_FONTS_ZIP"

NOTO_EMOJI_TTF='NotoColorEmoji.ttf'
NOTO_EMOJI_URL="https://github.com/googlefonts/noto-emoji/raw/main/fonts/$NOTO_EMOJI_TTF"

# Function to print messages to stderr
log() {
    printf "%s\n" "$*" >&2
}

# Function to create a temporary directory
create_temp_dir() {
    mktemp -d
}

# Function to retrieve the latest release URL from GitHub
get_latest_release_url() {
    local REPO=$1
    log "Retrieving the latest release URL for $REPO..."
    curl -s "https://api.github.com/repos/$REPO/releases/latest" | jq -r '.assets[] | select(.name | endswith(".zip")) | .browser_download_url'
}

# Function to download and install Monaspace
install_monaspace() {
    local temp_dir
    temp_dir=$(create_temp_dir)
    local dest_dir="$FONT_DIR/Monaspace"

    local url
    url="$(get_latest_release_url "$MONASPACE_REPO")"
    local zip
    zip="$(basename "$url")"

    log 'Downloading Monaspace...'
    curl -q -s -S -L -o "$temp_dir/$zip" "$url"

    log 'Extracting Monaspace...'
    unzip "$temp_dir/$zip" -d "$temp_dir"

    log 'Installing Monaspace...'
    mkdir -p "$dest_dir"
    cp "$temp_dir"/**/*.otf "$dest_dir"

    rm -rf "$temp_dir"
}

# Function to download and install Fira Code
install_fira_code() {
    local temp_dir
    temp_dir=$(create_temp_dir)
    local dest_dir="$FONT_DIR/FiraCode"

    local url
    url="$(get_latest_release_url "$FIRACODE_REPO")"
    local zip
    zip="$(basename "$url")"

    log 'Downloading Fira Code...'
    curl -q -s -S -L -o "$temp_dir/$zip" "$url"

    log 'Extracting Fira Code...'
    unzip "$temp_dir/$zip" -d "$temp_dir"

    log 'Installing Fira Code...'
    mkdir -p "$dest_dir"
    cp "$temp_dir"/**/*.ttf "$dest_dir"

    rm -rf "$temp_dir"
}

# Function to download and install Source Code Pro
install_source_code_pro() {
    local temp_dir
    temp_dir=$(create_temp_dir)
    local dest_dir="$FONT_DIR/SourceCodePro"

    local url
    url="$(get_latest_release_url "$SOURCE_CODE_PRO_REPO" | grep OTF)"
    local zip
    zip="$(basename "$url")"

    log 'Downloading Source Code Pro...'
    curl -q -s -S -L -o "$temp_dir/$zip" "$url"

    log 'Extracting Source Code Pro...'
    unzip "$temp_dir/$zip" -d "$temp_dir"

    log 'Installing Source Code Pro...'
    mkdir -p "$dest_dir"
    cp "$temp_dir"/**/*.otf "$dest_dir"

    rm -rf "$temp_dir"
}

# Function to download and install Nerd Fonts
install_nerd_fonts() {
    local temp_dir
    temp_dir=$(create_temp_dir)
    local dest_dir="$FONT_DIR/NerdFonts"

    log 'Downloading Nerd Fonts...'
    curl -q -s -S -L -o "$temp_dir/$NERD_FONTS_ZIP" "$NERD_FONTS_URL"

    log 'Extracting Nerd Fonts...'
    unzip "$temp_dir/$NERD_FONTS_ZIP" -d "$temp_dir"

    log 'Installing Nerd Fonts...'
    mkdir -p "$dest_dir"
    cp "$temp_dir"/**/*.ttf "$dest_dir"

    rm -rf "$temp_dir"
}

# Function to download and install Noto Emoji
install_noto_emoji() {
    local temp_dir
    temp_dir=$(create_temp_dir)
    local dest_dir="$FONT_DIR/NotoEmoji"

    log 'Downloading Noto Emoji...'
    curl -q -s -S -L -o "$temp_dir/$NOTO_EMOJI_TTF" "$NOTO_EMOJI_URL"

    log 'Installing Noto Emoji...'
    mkdir -p "$dest_dir"
    cp "$temp_dir/$NOTO_EMOJI_TTF" "$dest_dir"

    rm -rf "$temp_dir"
}

# Function to update font cache
update_font_cache() {
    log 'Updating font cache...'
    fc-cache -f "$FONT_DIR"
}

mkdir -p "$FONT_DIR"

install_monaspace

install_fira_code

install_source_code_pro

install_nerd_fonts

install_noto_emoji

update_font_cache

log 'Fonts installed successfully.'
