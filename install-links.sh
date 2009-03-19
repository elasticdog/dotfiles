#!/bin/bash

# Create needed directories if they don't already exist
mkdir -p "$HOME/.ssh"

FILES="
bash_profile
bashrc
factor-rc
gitconfig
gitignore
hgrc
irbrc
screenrc
ssh/config
vim
vimrc
zshenv
zshrc
"

# Create symbolic links for all configuration files
for file in $FILES
do
	SOURCE="$HOME/.dotfiles/$file"
	TARGET="$HOME/.$file"

	# Create backup file if the target already exists and is not a symlink
	if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]
	then
		echo "*** WARNING *** $TARGET already exists; copying original to $file.bak"
		cp -p "$TARGET" "$TARGET.bak"
	fi
	ln -hfsv "$SOURCE" "$TARGET"
done

exit 0
