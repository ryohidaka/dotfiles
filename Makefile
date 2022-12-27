#!/bin/sh
DIR=~/dotfiles

# シンボリックリンク作成用スクリプト
sync:

# zsh
	cd zsh && make sync

# Homebrew
	cd homebrew && make install

# VSCode
	cd vscode && make sync

# Prettier
	cd prettier && make sync

uninstall:

# zsh
	cd zsh && make delete

# Homebrew
	cd homebrew && make uninstall

# VSCode
	cd vscode && make delete

# Prettier
	cd prettier && make delete

