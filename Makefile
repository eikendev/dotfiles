DOTBOT_CONFIG := dotbot.yaml

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

.PHONY: init
init:
	sudo dnf install nix nix-daemon
	sudo systemctl enable --now nix-daemon
	@printf '\n%s\n%s\n\n' 'Nix is installed and the daemon is running.' 'Next, apply the configuration with: make install'

.PHONY: install
install: dotbot install-fish-plugins install-vim-plugins vim-mkspell install-fonts systemd

.PHONY: clean
clean:
	find -type d -name '__pycache__' -exec rm -rf {} +;
	find -type d -name '.mypy_cache' -exec rm -rf {} +;

.PHONY: dotbot
dotbot:
	uv tool run dotbot@latest -c "${DOTBOT_CONFIG}"

.PHONY: install-fish-plugins
install-fish-plugins:
	$(SCRIPTS_DIR)/install-fish-plugins

.PHONY: install-vim-plugins
install-vim-plugins:
	nvim --headless '+Lazy! sync' "+lua require('nvim-treesitter').update():wait(300000)" +qa

.PHONY: vim-mkspell
vim-mkspell:
	$(SCRIPTS_DIR)/vim-mkspell

.PHONY: install-fonts
install-fonts:
	$(SCRIPTS_DIR)/install-fonts

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
