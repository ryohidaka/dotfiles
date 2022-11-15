#!/bin/sh
DIR=~/dotfiles

# シンボリックリンク作成用スクリプト
sync:

# zsh
	ln -s ${DIR}/zsh/zshenv ~/.zshenv
	ln -s ${DIR}/zsh/zshrc ~/.zshrc

# VSCode
	ln -s ${DIR}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	ln -s ${DIR}/prettier/prettierrc.yaml ~/.prettierrc

uninstall:

# zsh
	rm -f ~/.zshenv
	rm -f ~/.zshrc

# VSCode
	rm -f ~/Library/Application\ Support/Code/User/settings.json

# Prettier
	rm -f ~/.prettierrc
