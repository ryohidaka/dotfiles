#!/bin/sh
DIR=~/dotfiles

# シンボリックリンク作成用スクリプト
sync:

# zsh
	ln -s ${DIR}/zsh/zshenv ~/.zshenv
	ln -s ${DIR}/zsh/zshrc ~/.zshrc
	ln -s ${DIR}/zsh/zprofile ~/.zprofile

# Homebrew
	ln -s ${DIR}/homebrew/Brewfile ~/.Brewfile

# VSCode
	ln -s ${DIR}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	ln -s ${DIR}/prettier/prettierrc.yaml ~/.prettierrc

# husky
	ln -s ${DIR}/husky/huskyrc ~/.huskyrc


uninstall:

# zsh
	rm -f ~/.zshenv
	rm -f ~/.zshrc
	rm -f ~/.zprofile

# Homebrew
	rm -f ~/.Brewfile

# VSCode
	rm -f ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	rm -f ~/.prettierrc

# husky
	rm -f ~/.huskyrc
