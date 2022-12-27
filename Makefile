#!/bin/sh
DIR=~/dotfiles

# シンボリックリンク作成用スクリプト
sync:

# zsh
	cd zsh && make sync

# Homebrew
	ln -s ${DIR}/homebrew/Brewfile ~/.Brewfile

# VSCode
	ln -s ${DIR}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	cd prettier && make sync

uninstall:

# zsh
	cd zsh && make delete

# Homebrew
	rm -f ~/.Brewfile

# VSCode
	rm -f ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	cd prettier && make delete

