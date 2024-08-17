#!/usr/bin/env bash

set -e

# Enable globstar for recursive globbing
shopt -s globstar

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

FONT_DIR="$XDG_DATA_HOME/fonts"

FIRACODE_REPO='tonsky/FiraCode'
MONASPACE_REPO='githubnext/monaspace'
SOURCE_CODE_PRO_REPO='adobe-fonts/source-code-pro'
NERD_FONTS_REPO='ryanoasis/nerd-fonts'

NERD_FONTS_FLAVOR='NerdFontsSymbolsOnly'

NOTO_EMOJI_TTF='NotoColorEmoji.ttf'
NOTO_EMOJI_URL='https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf'

log() {
    printf '%s\n' "$*" >&2
}

get_latest_release_url() {
    local repo="$1"
    local grep_filter="$2"

    log 'Retrieving the latest release URL for' "$repo..."

    if [ -n "$grep_filter" ]; then
        curl -s "https://api.github.com/repos/$repo/releases/latest" | jq -r ".assets[] | select(.name | endswith(\".zip\")) | select(.name | contains(\"$grep_filter\")) | .browser_download_url"
    else
        curl -s "https://api.github.com/repos/$repo/releases/latest" | jq -r '.assets[] | select(.name | endswith(".zip")) | .browser_download_url'
    fi
}

install_font() {
    local repo="$1"
    local font_name="$2"
    local ext="$3"
    local grep_filter="$4"

    local temp_dir
    temp_dir=$(mktemp -d)
    local dest_dir="$FONT_DIR/$font_name"

    local url
    url=$(get_latest_release_url "$repo" "$grep_filter")
    local zip
    zip=$(basename "$url")

    log 'Downloading' "$font_name..."
    curl -q -s -S -L -o "$temp_dir/$zip" "$url"

    log 'Extracting' "$font_name..."
    unzip "$temp_dir/$zip" -d "$temp_dir"

    log 'Installing' "$font_name..."
    mkdir -p "$dest_dir"
    cp "$temp_dir"/**/*."$ext" "$dest_dir"

    rm -rf "$temp_dir"
}

install_noto_emoji() {
    local dest_dir="$FONT_DIR/Noto Emoji"

    log 'Downloading and installing Noto Emoji...'
    mkdir -p "$dest_dir"
    curl -q -s -S -L -o "$dest_dir/$NOTO_EMOJI_TTF" "$NOTO_EMOJI_URL"
}

mkdir -p "$FONT_DIR"

install_font "$MONASPACE_REPO" 'Monaspace' 'otf'

install_font "$FIRACODE_REPO" 'Fira Code' 'ttf'

install_font "$SOURCE_CODE_PRO_REPO" 'Source Code Pro' 'otf' 'OTF'

install_font "$NERD_FONTS_REPO" 'Nerd Fonts' 'ttf' "$NERD_FONTS_FLAVOR"

install_noto_emoji

log 'Updating font cache...'
fc-cache -f "$FONT_DIR"

log 'Fonts installed successfully.'
