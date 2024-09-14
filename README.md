# .dotfiles
[![License](https://img.shields.io/github/license/c012vu5/.dotfiles.svg?style=flat-square)](./LICENSE) [![Ubuntu](https://github.com/c012vu5/.dotfiles/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/c012vu5/.dotfiles/actions/workflows/ubuntu.yml)

My dotfiles to install init.el, fish related files, and so on.

## Usage
```console
./install.sh
```

## Range
This script will:
- Embed `exec fish` in rc file of login shell
- Create a symlink for emacs `init.el`
- Create symlinks for fish related files
- Edit ~/.gitconfig a.k.a. `git config --global`
