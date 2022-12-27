#!/bin/sh
DIR=~/dotfiles

# シンボリックリンク作成用スクリプト
sync:

# zsh
	ln -s ${DIR}/zsh/zshenv ~/.zshenv
	ln -s ${DIR}/zsh/zshrc ~/.zshrc

# Homebrew
	ln -s ${DIR}/homebrew/Brewfile ~/.Brewfile

# VSCode
	ln -s ${DIR}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	cd prettier && make sync

uninstall:

# zsh
	rm -f ~/.zshenv
	rm -f ~/.zshrc

# Homebrew
	rm -f ~/.Brewfile

# VSCode
	rm -f ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	cd prettier && make delete

