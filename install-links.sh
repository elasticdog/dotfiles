#!/bin/bash

# Create needed directories if they don't already exist
mkdir -p "$HOME/.bazaar"
mkdir -p "$HOME/.hgext"
mkdir -p "$HOME/.ssh"

FILES="
bash_profile
bashrc
bazaar/authentication.conf
bazaar/bazaar.conf
ctags
factor-boot-rc
gemrc
gitconfig
gitignore
hgext/hgshelve.py
hgrc
irbrc
rpmmacros
screenrc
ssh/config
tmux.conf
vim
vimrc
zpath
zprofile
zsh
zshenv
zshrc
"

# Create symbolic links for all configuration files
for file in $FILES
do
	SOURCE="$HOME/.dotfiles/$file"
	TARGET="$HOME/.$file"

	# Create backup file if the target already exists and is not a symlink
	if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
		echo "*** WARNING *** $TARGET already exists; copying original to .$file.old"
		mv "$TARGET" "$TARGET.old"
	fi
	case $OSTYPE in
		darwin*)
			ln -hfsv "$SOURCE" "$TARGET"
			;;
		linux*)
			ln -fsv "$SOURCE" "$TARGET"
			;;
	esac
done

exit 0
