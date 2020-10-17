BASEDIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOTBOT_CONFIG=dotbot.yaml
DOTBOT_DIR=dotbot

.PHONY: install
install: githook dotbot reveal packages submodules vim_plug vim_mkspell install_gef systemd

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
	test -f ./source/ssh/config && chmod 600 ./source/ssh/config
	git secret reveal
	chmod 400 ./source/ssh/config
	@printf "%s\n" 'Adjusting permissions of secrets.'
	@for f in $$(git secret list); do chmod go-rwx "$$f"; done

.PHONY: packages_cargo
packages_cargo:
	cargo install bandwhich
	cargo install cargo-crev
	cargo install diffr
	cargo install diskus
	cargo install hexyl
	cargo install hyperfine
	cargo install pastel
	cargo install rage
	cargo install tealdeer
	cargo install turs
	cargo install websocat
	cargo install xsv

.PHONY: packages_gem
packages_gem:
	gem install travis

.PHONY: packages_go
packages_go:
	go get -u -v arp242.net/uni
	go get -u -v github.com/sourcegraph/go-langserver
	GO111MODULE=on go get -u -v github.com/charmbracelet/glow

.PHONY: packages
packages: packages_cargo packages_gem packages_go

.PHONY: submodules
submodules:
	git submodule update --init --recursive
	git submodule update --remote

.PHONY: vim_plug
vim_plug:
	curl -q -s -S -L --create-dirs -o ~/.local/share/nvim/site/autoload/plug.vim 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim --headless -c 'silent PlugClean!' -c 'silent PlugUpdate' -c 'silent PlugInstall' -c 'quitall!'
	nvim --headless -c 'silent CocUpdateSync' -c 'quitall!'

.PHONY: vim_mkspell
vim_mkspell:
	vim-mkspell

.PHONY: install_gef
install_gef:
	curl -q -s -S -L --create-dirs -o ~/.local/share/gef/init.py 'https://github.com/hugsy/gef/raw/master/gef.py'

.PHONY: systemd
systemd:
	systemctl --user daemon-reload
	systemctl --user enable --now thunderbird-unread.service
	systemctl --user enable --now sync-news.timer
	systemctl --user enable --now sync-repositories.timer
	systemctl --user enable --now sync-rfcs.timer
