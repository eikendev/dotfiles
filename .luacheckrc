-- Lua lint configuration, run by `nix flake check`.

std = 'luajit'
globals = { 'vim' }
max_line_length = false

-- Vendored yazi plugins are upstream code.
exclude_files = { '**/yazi/plugins/**' }
