## About

This repository contains my configuration files.
They are mainly intended for personal use, but since I am regularly asked how I've set up a certain program I'm happy to share this repository with everyone.

Some configuration files are inspired by other repositories, others were originally authored by myself.
I've tried to give credit where appropriate, but I might have missed something.

You may encounter encrypted files in other parts of this repository.
These contain sensitive information and are hence not publicly available.

## Installation

### Dotbot

To install the configuration files, simply use the `install` Make target.
You may not be able to decrypt some secrets, hence some things might not work as expected.

### Git Hooks

To automate certain behavior in this repository I created the `githook/` directory where all important hooks for Git are located.
For convenience, you can simply issue `make githook` to install these hooks.
The hooks will be updated from time to time, but the installation script should take that into account already.
