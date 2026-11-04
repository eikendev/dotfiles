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
install: switch gc

# Bumps flake.lock and lazy-lock.json and refreshes everything fetched from upstream.
.PHONY: update
update:
	nix flake update
	nvim --headless '+Lazy! update' +qa
	$(SCRIPTS_DIR)/install-go
	$(SCRIPTS_DIR)/install-rust
	$(SCRIPTS_DIR)/install-gef
	$(SCRIPTS_DIR)/vim-mkspell
	tldr --update
ifneq ($(wildcard $(PRIVATE_DIR)/Makefile),)
	$(MAKE) -C $(PRIVATE_DIR) update
endif

.PHONY: switch
switch:
	nix run "$(CURDIR)#home-manager" -- switch --flake "$(CURDIR)#default" $(HM_FLAGS)

.PHONY: gc
gc:
	nix-collect-garbage --delete-older-than 30d

.PHONY: fmt
fmt:
	nix fmt

.PHONY: lint
lint: lint-shell lint-fish lint-yaml lint-flake

.PHONY: lint-flake
lint-flake:
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
