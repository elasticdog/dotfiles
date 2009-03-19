#
# ~/.zshrc
#

##### Shell Options

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=2000
SAVEHIST=1500

bindkey -v  # use vi-style command line editing
stty -ixon  # disable ^S/^Q (XON/XOFF) flow control

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

# message formatting
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'

# describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# use completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${HOME}/.zsh_cache

# case-insensitive completion (uppercase from lowercase & underscores from dashes)
zstyle ':completion:*' matcher-list 'm:{a-z-}={A-Z_}'

# initialize the tab completion system
autoload -Uz compinit
compinit

# enable powerful pattern-based renaming
autoload zmv

setopt append_history        # history appends to existing file
setopt auto_pushd            # cd uses directory stack too
setopt correct_all           # correct spelling of all arguments
setopt extended_glob         # use extended paterns while globbing
setopt hist_ignore_all_dups  # remove all earlier duplicate lines
setopt hist_ignore_space     # do not store lines starting with space
setopt pushd_ignore_dups     # do not push dir multiply on stack

setopt no_beep               # disable beep on all errors
setopt no_case_glob          # disable glob case sensitivity

function zsh_prompt {
	local DEFAULT=$'%{\e[0m%}'
	local LIGHT_BLUE=$'%{\e[1;34m%}'
	local LIGHT_CYAN=$'%{\e[1;36m%}'
	local LIGHT_RED=$'%{\e[1;31m%}'
	local WHITE=$'%{\e[1;37m%}'

	PROMPT="${LIGHT_BLUE}[${DEFAULT}%n@%m ${WHITE}%c${LIGHT_BLUE}]${LIGHT_CYAN} %# ${DEFAULT}"
}
zsh_prompt


##### OS-Specific Command Aliases

case $OSTYPE in
	darwin*)
		alias ls='ls -GF'            # list in color with identifiers
		alias gvimdiff='mvim -d -g'  # use MacVim for gvimdiff
		;;
	linux*)
		alias ls='ls --color=auto --file-type'  # list in color with identifiers
		alias vim='TERM=gnome-256color vim'     # force 256-color support

		# Arch Linux
		if [[ -f /etc/arch-release ]]; then
			# shortcut for full system upgrade with root privilege check
			[[ -x $(which sudo) ]] && alias upgrade='sudo pacman -Syu'
		fi
		;;
esac


##### Command Aliases

# no spelling correction for these commands
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

# set default options
alias grep='grep --color=auto'  # show the matching string in color
alias less='less --ignore-case --LONG-PROMPT'
alias spec='spec --color'

# ls hacking
alias lsd='ls -d *(-/N)'      # list visible directories
alias lsf='ls *(-.N)'         # list visible files
alias la='ls -A'              # list all files/directories
alias lad='ls -d *(-/DN)'     # list all directories
alias laf='ls -A *(-.DN)'     # list all files
alias lla='ls -lhd *(-DN)'    # list details of all files/directories
alias llad='ls -lhd *(-/DN)'  # list details of all directories
alias llaf='ls -lhA *(-.DN)'  # list details of all files
alias ll='ls -lh'             # list details of visible files/directories
alias lld='ls -lhd *(-/N)'    # list details of visible directories
alias llf='ls -lh *(-.N)'     # list details of visible files
alias lh='ls -d .*'           # list hidden files/directories
alias lhd='ls -d .*(-/N)'     # list hidden directories
alias lhf='ls .*(-.N)'        # list hidden files
alias llh='ls -lhd .*'        # list details of hidden files/directories
alias llhd='ls -lhd .*(-/N)'  # list details of hidden directories
alias llhf='ls -lh .*(-.N)'   # list details of hidden files

alias le='ls -d *(-/DN^F)'         # list all empty directories
alias ler='ls -d **/*(-/DN^F)'     # list all empty directories recursively
alias lle='ls -ld *(-/DN^F)'       # list details of all empty directories
alias ller='ls -lhd **/*(-/DN^F)'  # list details of all empty directories recursively

# fast directory changing
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# show sorted directory sizes for all directories
alias dua='du -s *(/DN) | sort -nr | cut -f 2- | while read directory; do du -sh "$directory/"; done'

# show sorted directory sizes for visible directories only
alias duv='du -s *(/N) | sort -nr | cut -f 2- | while read directory; do du -sh "$directory/"; done'

# show sorted directory sizes for hidden directories only
alias duh='du -s .*(/N) | sort -nr | cut -f 2- | while read directory; do du -sh "$directory/"; done'

# show sorted file sizes in the current directory
alias duf='find . -type f -maxdepth 1 -print0 | xargs -0 -L 1 wc -c | sort -nr | sed "s/\.\// /"'

alias -g C='clear && '
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g N='> /dev/null 2>&1'
alias -g S='| sort'
alias -g T='| tail'
alias -g W='| wc -l'

alias -g ND='$(ls -d *(/om[1])N)'  # newest directory
alias -g NF='$(ls *(.om[1])N)'     # newest file

# shortcut for optipng's most exhaustive search
[[ -x $(which optipng) ]] && alias optimax='optipng -zc1-9 -zm1-9 -zs0-3 -f0-5'

# web cat
[[ -x $(which wget) ]] && alias wcat='wget -q -O - '


##### Custom Functions

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

# ssh and start a screen session on the remote server
function sshs {
	if [[ -z $* ]]; then
		echo 'Usage: sshs [options] [user@]hostname'
		echo 'SSH and automatically start a GNU screen session on the remote server'
	else
		ssh -t $* screen -DRU
	fi
}


##### http://www.cs.drexel.edu/~mjw452/.zshrc

# check if a file can be autoloaded by trying to load it in a subshell
function autoloadable {
	(unfunction $1; autoload -U +X $1) &>/dev/null
}

# allow interactive editing of command line in $EDITOR
if autoloadable edit-command-line; then
	autoload -U edit-command-line
	zle -N edit-command-line
	bindkey "\ee" edit-command-line  # <Esc-e>
fi
