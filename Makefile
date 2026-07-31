DOTBOT_CONFIG := dotbot.yaml

SCRIPTS_DIR := ./scripts

XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: install
install: dotbot install-fish-plugins install-fish-completions install-vim-plugins vim-mkspell install-fonts systemd

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

.PHONY: install-fish-completions
install-fish-completions:
	curl -q -s -S -L --create-dirs -o $(XDG_CONFIG_HOME)/fish/completions/task.fish 'https://raw.githubusercontent.com/go-task/task/main/completion/fish/task.fish'

.PHONY: install-vim-plugins
install-vim-plugins:
	nvim --headless '+Lazy! sync' +qa

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
