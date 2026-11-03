SCRIPTS_DIR := ./scripts

XDG_CONFIG_HOME ?= $(HOME)/.config

# Optional private overlay, see README. The .env file is not tracked.
-include .env

HM_FLAGS :=
ifneq ($(strip $(PRIVATE_DIR)),)
ifneq ($(wildcard $(PRIVATE_DIR)/.),)
HM_FLAGS += --override-input private path:$(PRIVATE_DIR) --no-write-lock-file
endif
endif

NIX_CONF := /etc/nix/nix.conf

.PHONY: init
init:
	sudo dnf install nix nix-daemon
	sudo systemctl enable --now nix-daemon
	@if ! grep -qs '^use-xdg-base-directories' "$(NIX_CONF)"; then \
		echo 'use-xdg-base-directories = true' | sudo tee -a "$(NIX_CONF)" >/dev/null; \
		sudo systemctl restart nix-daemon; \
	fi
	@printf '\n%s\n%s\n\n' 'Nix is installed and the daemon is running.' 'Next, apply the configuration with: make install'

.PHONY: install
install: switch install-vim-plugins vim-mkspell systemd

.PHONY: switch
switch:
	DOTFILES_DIR="$(CURDIR)" nix run "$(CURDIR)#home-manager" -- switch --impure --flake "$(CURDIR)#default" $(HM_FLAGS)

.PHONY: clean
clean:
	find -type d -name '__pycache__' -exec rm -rf {} +;
	find -type d -name '.mypy_cache' -exec rm -rf {} +;

.PHONY: install-vim-plugins
install-vim-plugins:
	nvim --headless '+Lazy! sync' "+lua require('nvim-treesitter').update():wait(300000)" +qa

.PHONY: vim-mkspell
vim-mkspell:
	$(SCRIPTS_DIR)/vim-mkspell

.PHONY: systemd
systemd:
	systemctl --user daemon-reload
	systemctl --user enable --now tbunread.service

.PHONY: lint
lint: lint-shell lint-fish lint-yaml

.PHONY: lint-shell
lint-shell:
	git ls-files scripts source \
		| xargs grep -lE '^#!.*(bash|/bin/sh)' \
		| xargs -r uv tool run --from shellcheck-py shellcheck -x

.PHONY: lint-fish
lint-fish:
	{ git ls-files scripts source | grep '\.fish$$'; \
		git ls-files scripts source | xargs grep -lE '^#!.*fish'; } \
		| sort -u \
		| xargs -r -n1 fish --no-execute

.PHONY: lint-yaml
lint-yaml:
	git ls-files '*.yaml' '*.yml' | xargs -r uv tool run yamllint
