#!/bin/sh
DIR=~/dotfiles

# シンボリックリンク作成用スクリプト
sync:

# zsh
	cd zsh && make sync

# Homebrew
	ln -s ${DIR}/homebrew/Brewfile ~/.Brewfile

# VSCode
	cd vscode && make sync

# Prettier
	cd prettier && make sync

uninstall:

# zsh
	cd zsh && make delete

# Homebrew
	rm -f ~/.Brewfile

# VSCode
	cd vscode && make delete

# Prettier
	cd prettier && make delete

