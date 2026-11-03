SCRIPTS_DIR := ./scripts

XDG_CONFIG_HOME ?= $(HOME)/.config

# Optional private overlay, see README.
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
install: update switch install-vim-plugins gc

.PHONY: update
update:
	nix flake update

.PHONY: switch
switch:
	DOTFILES_DIR="$(CURDIR)" nix run "$(CURDIR)#home-manager" -- switch --impure --flake "$(CURDIR)#default" $(HM_FLAGS)

# Keep 30 days of generations for rollback.
.PHONY: gc
gc:
	nix-collect-garbage --delete-older-than 30d

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

.PHONY: fmt
fmt:
	nix fmt

.PHONY: lint
lint: lint-shell lint-fish lint-yaml lint-nix

.PHONY: lint-nix
lint-nix:
	nix flake check

.PHONY: lint-shell
lint-shell:
	git ls-files scripts source \
		| xargs grep -lE '^#!.*[/[:space:]](ba)?sh$$' \
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
