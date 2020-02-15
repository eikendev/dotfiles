BASEDIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOTBOT_CONFIG=dotbot.yaml
DOTBOT_DIR=dotbot

.PHONY: install
install: packages submodules compile dotbot vim_plugins install_gef

.PHONY: clean
clean:
	find -type d -name '__pycache__' -exec rm -rf {} +;
	find -type d -name '.mypy_cache' -exec rm -rf {} +;

.PHONY: packages
packages:
	cargo install bandwhich
	cargo install cargo-crev
	cargo install diffr
	cargo install diskus
	cargo install hyperfine
	cargo install pastel
	cargo install tealdeer
	cargo install websocat
	go get -u arp242.net/uni
	go get -u github.com/gohugoio/hugo

.PHONY: reveal
reveal:
	chmod 600 ./source/ssh/config
	git secret reveal
	chmod 400 ./source/ssh/config

.PHONY: submodules
submodules:
	git submodule update --init --recursive
	git submodule update --remote

.PHONY: compile
compile:
	cd vendor/turs && cargo build --release

.PHONY: dotbot
dotbot:
	set -e; \
	cd "${BASEDIR}"; \
	git submodule update --init --recursive "${DOTBOT_DIR}"; \
	"${BASEDIR}/${DOTBOT_DIR}/bin/dotbot" -d "${BASEDIR}" -c "${DOTBOT_CONFIG}"

.PHONY: vim_plugins
vim_plugins:
	nvim --headless -c 'PlugUpgrade' -c 'PlugClean!' -c 'PlugUpdate' -c 'PlugInstall' -c 'quitall'

.PHONY: install_gef
install_gef:
	mkdir -p ~/.local/share/gef
	wget -q -O ~/.local/share/gef/init.py https://github.com/hugsy/gef/raw/master/gef.py
