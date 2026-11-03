## About

This repository contains my configuration files.
They are mainly intended for personal use, but since I am regularly asked how I've set up a certain program I'm happy to share this repository with everyone.

Some configuration files are inspired by other repositories, others were originally authored by myself.
I've tried to give credit where appropriate, but I might have missed something.

The programs being configured are installed with the distribution's package manager and are not part of this repository.

## Installation

The setup targets Fedora.
It uses [Nix](https://nixos.org) with [Home Manager](https://nix-community.github.io/home-manager/) to link the configuration files into place and to run the remaining setup steps.

### New machine

Clone the repository to a location of your choice and run the `init` Make target once:

```sh
git clone https://github.com/eikendev/dotfiles.git
cd dotfiles
make init
```

The target installs Nix from the Fedora repositories, enables the Nix daemon, and configures Nix to keep its per-user files in XDG directories.
It asks for `sudo` and is safe to run again.
Afterwards, apply the configuration:

```sh
make install
```

### Updates

Run the `install` Make target whenever you want to apply changes:

```sh
make install
```

To move to newer versions of the pinned inputs, bump the lock files, apply them, and commit the result:

```sh
make update
make install
```

This updates the Nix inputs in `flake.lock` and the Neovim plugins in `source/nvim/lazy-lock.json`.

### Private overlay

The public setup works on its own.
An optional private overlay can add packages, files and setup steps that do not belong into a public repository.

To enable it, create a file named `.env` in the repository root with the path of the overlay:

```sh
PRIVATE_DIR=/path/to/private
```

The file is ignored by git.
The overlay is a Nix flake that exports a Home Manager module as `homeModules.default`.
When the directory does not exist, the public setup is applied without it.
