BASEDIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOTBOT_CONFIG=dotbot.yaml
DOTBOT_DIR=dotbot

.PHONY: install
install: githook submodules dotbot rustup vim_plugin vim_mkspell install_gef systemd

.PHONY: githook
githook:
	./githook/setup-hooks

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

.PHONY: reveal
reveal:
	test -f ./source/ssh/config && chmod 600 ./source/ssh/config || true
	git secret reveal
	chmod 400 ./source/ssh/config
	@printf "%s\n" 'Adjusting permissions of secrets.'
	@for f in $$(git secret list); do chmod go-rwx "$$f"; done

.PHONY: rustup
rustup:
	rustup update nightly
	rustup update stable
	cargo install -f cargo-edit
	cargo install -f cargo-geiger

.PHONY: submodules
submodules:
	git submodule update --init --recursive
	git submodule update --remote

.PHONY: vim_plugin
vim_plugin:
	curl -q -s -S -L --create-dirs -o ~/.local/share/nvim/site/autoload/plug.vim 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim --headless -c 'silent PlugClean!' -c 'silent PlugUpdate' -c 'silent PlugInstall' -c 'quitall!'

.PHONY: vim_mkspell
vim_mkspell:
	vim-mkspell

.PHONY: install_gef
install_gef:
	curl -q -s -S -L --create-dirs -o ~/.local/share/gef/init.py 'https://github.com/hugsy/gef/raw/master/gef.py'

.PHONY: systemd
systemd:
	systemctl --user daemon-reload
	systemctl --user enable --now tbunread.service
