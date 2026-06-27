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
	nvim --headless -c 'Lazy sync' -c 'lua vim.loop.timer_start(vim.loop.new_timer(), 10000, 0, vim.schedule_wrap(function() vim.cmd("quitall!") end))'

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
