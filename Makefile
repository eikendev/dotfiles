BASEDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOTBOT_CONFIG := dotbot.yaml
DOTBOT_DIR := dotbot

SCRIPTS_DIR := ./scripts

XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

.PHONY: install
install: submodules dotbot update_go update_fisher rustup fish_completions vim_plugins vim_mkspell install_gef systemd fonts

.PHONY: clean
clean:
	find -type d -name '__pycache__' -exec rm -rf {} +;
	find -type d -name '.mypy_cache' -exec rm -rf {} +;

.PHONY: dotbot
dotbot:
	set -e; \
	cd "${BASEDIR}"; \
	git submodule update --init --recursive "${DOTBOT_DIR}"; \
	"${BASEDIR}/${DOTBOT_DIR}/bin/dotbot" -d "${BASEDIR}" -c "${DOTBOT_CONFIG}"

.PHONY: update_go
update_go:
	./bin/update-go

.PHONY: update_fisher
update_fisher:
	fish -c 'fisher update'

.PHONY: rustup
rustup:
	rustup update nightly
	rustup update stable

.PHONY: submodules
submodules:
	git submodule update --init --recursive
	git submodule update --remote

.PHONY: fish_completions
fish_completions:
	curl -q -s -S -L --create-dirs -o $(XDG_CONFIG_HOME)/fish/completions/task.fish 'https://raw.githubusercontent.com/go-task/task/main/completion/fish/task.fish'

.PHONY: vim_plugins
vim_plugins:
	nvim --headless -c 'Lazy sync' -c 'lua vim.loop.timer_start(vim.loop.new_timer(), 10000, 0, vim.schedule_wrap(function() vim.cmd("quitall!") end))'

.PHONY: vim_mkspell
vim_mkspell:
	$(SCRIPTS_DIR)/vim-mkspell

.PHONY: install_gef
install_gef:
	curl -q -s -S -L --create-dirs -o $(XDG_DATA_HOME)/gef/init.py 'https://raw.githubusercontent.com/hugsy/gef/main/gef.py'

.PHONY: systemd
systemd:
	systemctl --user daemon-reload
	systemctl --user enable --now tbunread.service

.PHONY: fonts
fonts:
	$(SCRIPTS_DIR)/install-fonts
