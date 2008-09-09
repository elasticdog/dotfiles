#
# ~/.bashrc
#

# Source global definitions if available
if [[ -f /etc/bashrc ]]; then
	source /etc/bashrc
fi


##### Environment & Shell Variables

export BROWSER='firefox'
export EDITOR='vim'
export HISTCONTROL='ignoreboth'
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear"
export PAGER='less'
export TERM='xterm-xfree86'

function bash_prompt {
	local DEFAULT="\[\033[0m\]"
	local LIGHT_BLUE="\[\033[1;34m\]"
	local LIGHT_CYAN="\[\033[1;36m\]"
	local LIGHT_RED="\[\033[1;31m\]"
	local WHITE="\[\033[1;37m\]"

	PS1="$LIGHT_BLUE[$DEFAULT\u@\h $WHITE\W$LIGHT_BLUE]$LIGHT_CYAN \$ $DEFAULT"
}
bash_prompt

complete -d cd  # tab complete only directories when using cd
set -o vi       # enable vi-style command line editing
stty -ixon      # disable ^S/^Q (XON/XOFF) flow control


##### OS-Specific Command Aliases

case $OSTYPE in
	darwin*)
		alias ls='ls -GF'            # list in color with identifiers
		alias gvimdiff='mvim -d -g'  # use MacVim for gvimdiff
		;;
	linux*)
		alias ls='ls --color=auto --file-type'  # list in color with identifiers

		# Arch Linux
		if [[ -f /etc/arch-release ]]; then
			# shortcut for full system upgrade with root privilege check
			[[ -x $(which sudo) ]] && alias upgrade='sudo pacman -Syu'
		fi
		;;
esac


##### Command Aliases

alias la='ls -A'        # list all files/directories
alias lla='ls -lhA'     # list details of all files/directories
alias ll='ls -lh'       # list details of visible files/directories
alias lh='ls -d .*'     # list hidden files/directories
alias llh='ls -lhd .*'  # list details of hidden files/directories


##### Custom Functions

# list only directories
function lsd { ls -l --file-type $* | grep /; }

# extract various types of archive files
function extract {
	if [[ -z $1 ]]; then
		echo 'Usage: extract ARCHIVE'
		echo 'Extract files from ARCHIVE to the current directory'
	elif [[ -r $1 ]]; then
		case $1 in
			*.rar)      unrar x $1     ;;
			*.tar)      tar -xvf $1    ;;
			*.tar.bz2)  tar -xjvf $1   ;;
			*.bz2)      bzip2 -d $1    ;;
			*.tar.gz)   tar -xzvf $1   ;;
			*.gz)       gunzip -d $1   ;;
			*.tgz)      tar -xzvf $1   ;;
			*.Z)        uncompress $1  ;;
			*.zip)      unzip $1       ;;

			*) echo "ERROR: '$1' is not a known archive type"  ;;
		esac
	else
		echo "ERROR: '$1' is not a valid file"
	fi
}

# find file by name in the current directory
function ff {
	if [[ -z $1 ]]; then
		echo 'Usage: ff PATTERN'
		echo 'Recursively search for a file named PATTERN in the current directory'
	else
		find . -type f -iname $1
	fi
}

# find directory by name in the current directory
function fd {
	if [[ -z $1 ]]; then
		echo 'Usage: fd PATTERN'
		echo 'Recursively search for a directory named PATTERN in the current directory'
	else
		find . -type d -iname $1
	fi
}
