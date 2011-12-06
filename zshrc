#
# ~/.zshrc
#

##### Shell Options

HISTFILE="$HOME/.zsh_history"
HISTSIZE=2000
SAVEHIST=1500

# up/down browses history or searches for the specified string
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey -v  # use vi-style command line editing
stty -ixon  # disable ^S/^Q (XON/XOFF) flow control

[[ $OSTYPE == darwin* ]] && stty status '^T'  # ensure status character is set

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=4

# message formatting
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'

# describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# use completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh_cache

# case-insensitive completion (uppercase from lowercase & underscores from dashes)
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**'

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


##### OS-Specific Command Aliases

case $OSTYPE in
	darwin*)
		alias ls='ls -GF'            # list in color with identifiers
		alias gvimdiff='mvim -d -g'  # use MacVim for gvimdiff
		;;
	linux*)
		alias ls='ls --color=auto --file-type'  # list in color with identifiers

		[[ -x $(which dtach 2>/dev/null) ]] && alias factor='dtach -n /tmp/factor.sock factor'

		# Arch Linux
		if [[ -f /etc/arch-release ]]; then
			# shortcut for full system upgrade with root privilege check
			[[ -x $(which sudo 2>/dev/null) ]] && alias upgrade='sudo pacman -Syu'
		fi
		;;
esac


##### Command Aliases

# no spelling correction for these commands
for com in cp knife mkdir mv; do
	alias $com="nocorrect $com"
done

# set default options
alias grep='grep --color=auto'  # show the matching string in color
alias less='less --ignore-case --LONG-PROMPT'

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

# force clear scrollback buffer on urxvt
alias cls="echo -ne '\033c'"

# show sorted directory sizes for all directories
alias dua='du -s *(/DN) | sort -nr | cut -f 2- | while read directory; do du -sh "$directory/"; done'

# show sorted directory sizes for visible directories only
alias duv='du -s *(/N) | sort -nr | cut -f 2- | while read directory; do du -sh "$directory/"; done'

# show sorted directory sizes for hidden directories only
alias duh='du -s .*(/N) | sort -nr | cut -f 2- | while read directory; do du -sh "$directory/"; done'

# show sorted file sizes in the current directory
function duf {
	case $OSTYPE in
		darwin*)
			ls -AlhHS *(-.DN) | tr -s ' ' | cut -d ' ' -f 5,8 | awk '{ printf "%4s\t%s\n", $1, $2 }'
			;;
		linux*)
			ls -AlhHS *(-.DN) | tr -s ' ' | cut -d ' ' -f 5,9 | awk '{ printf "%4s\t%s\n", $1, $2 }'
			;;
	esac
}

# shortcut for optipng's most exhaustive search
[[ -x $(which optipng 2>/dev/null) ]] && alias optimax='optipng -zc1-9 -zm1-9 -zs0-3 -f0-5'

# ssh without using known_hosts protection
alias sshkh='ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# scp without using known_hosts protection
alias scpkh='scp -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# web cat
[[ -x $(which wget 2>/dev/null) ]] && alias wcat='wget -q -O - '

### git aliases

# shortcut for git-add hunk staging
alias gap='git add --patch'

alias gmup='master_update'
alias gmpu='master_push'
alias gsyn='sync_repo'
alias gbcr='branch_create'
alias gbup='branch_update'
alias gblg='branch_log'
alias gbdf='branch_diff'
alias gbmg='branch_merge'


##### Global Aliases

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -g A='| column -t'
alias -g C='clear && '
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g N='> /dev/null 2>&1'
alias -g P='ps aux | grep'
alias -g S='| sort'
alias -g T='| tail'
alias -g W='| wc -l'

alias -g ND='$(ls -d *(/om[1])N)'  # newest directory
alias -g NF='$(ls *(.om[1])N)'     # newest file


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

# ssh and attach to or start a tmux session on the remote server
function ssht {
	if [[ -z $* ]]; then
		echo 'Usage: sshs [options] [user@]hostname'
		echo 'SSH and automatically start a GNU screen session on the remote server'
	else
		ssh -t $* tmux attach
	fi
}

### git functions

master_update() {
	local CURRENT
	CURRENT=${$(git symbolic-ref -q HEAD)##refs/heads/}
	git checkout master
	git pull --rebase
	git checkout $CURRENT
}

master_push() {
	local CURRENT
	CURRENT=${$(git symbolic-ref -q HEAD)##refs/heads/}
	git checkout master
	git push
	git checkout $CURRENT
}

sync_repo() {
	master_update
	master_push
}

branch_create() {
	if [[ -z $1 ]]; then
		echo 'Usage: branch_create <branchname>'
		echo 'Creates a new branch head named <branchname> which points to master'
	else
		git checkout -b "$1" master
	fi
}

branch_update() {
	master_update
	git rebase master
}

branch_log() {
	local CURRENT
	CURRENT=${$(git symbolic-ref -q HEAD)##refs/heads/}
	echo "Commits in branch \"${CURRENT}\", but not \"master\":"
	git log master..${CURRENT} --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative
}

branch_diff() {
	local CURRENT
	CURRENT=${$(git symbolic-ref -q HEAD)##refs/heads/}
	echo "Commits in branch \"${CURRENT}\", but not \"master\":"
	git diff master..${CURRENT}
}

branch_merge() {
	local CURRENT
	CURRENT=${$(git symbolic-ref -q HEAD)##refs/heads/}
	branch_update
	git checkout master
	git merge --squash --no-commit "$CURRENT"
	git commit
}

### http://www.cs.drexel.edu/~mjw452/.zshrc

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


##### Custom Prompt

precmd () { vcs_info 'prompt' }

setprompt () {
	# See these pages for info on special characters:
	#   http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
	#   http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC273

	autoload -Uz vcs_info  # enable the use of VCS information
	setopt prompt_subst    # perform expansions and substitutions within prompts

	local VCS_PATH="%F{green}%r/%S%f"            # display only repo path when inside a repo
	local REG_PATH="%F{yellow}%~%f"              # display full path when outside a repo

	local VCS_USER="%%(!.%F{red}.%F{blue})%n%f"  # display username in red when root inside a repo
	local REG_USER="%(!.%F{red}.%F{blue})%n%f"   # display username in red when root outside a repo

	local VCS_HOST="%F{cyan}%%m%f"               # display hostname when inside a repo
	local REG_HOST="%F{cyan}%m%f"                # display hostname when outside a repo

	local VCS_INFO="%s %F{green}%c%u%b%f"        # current VCS name and branch

	zstyle ':vcs_info:*:prompt:*' enable bzr cvs git hg svn  # only enable checking for these VCSs
	zstyle ':vcs_info:*:prompt:*' check-for-changes true     # can be slow, but displays working dir & index changes
	zstyle ':vcs_info:*:prompt:*' unstagedstr '%F{red}*'     # display this when there are unstaged changes
	zstyle ':vcs_info:*:prompt:*' stagedstr '%F{yellow}+'    # display this when there are staged changes

	# sets vcs_info_msg_{0,1}_ when inside a repo, when inside a repo and performing an action, and when not inside a repo
	zstyle ':vcs_info:*:prompt:*' formats       "${VCS_PATH}" "${VCS_USER} at ${VCS_HOST} on ${VCS_INFO}"
	zstyle ':vcs_info:*:prompt:*' actionformats "${VCS_PATH}" "${VCS_USER} at ${VCS_HOST} on ${VCS_INFO} (%a)"
	zstyle ':vcs_info:*:prompt:*' nvcsformats   "${REG_PATH}" "${REG_USER} at ${REG_HOST}"

	local FMT_PATH='${vcs_info_msg_0_}'    # necessary to allow expansion elsewhere
	local ERR_EXIT="%(?..%F{red}[%?] )%f"  # conditionally display any non-zero exit status

	# the actual prompt definitions
	PROMPT="${FMT_PATH} ${ERR_EXIT}%F{magenta}%# %f"  # left prompt
	RPROMPT='${vcs_info_msg_1_}'                      # right prompt
	PS2="%_ %F{8}>%F{13}>%F{magenta}> %f"             # continuation prompt

	# spelling prompt
	SPROMPT="Correct %F{red}%R%f to %F{green}%r%f [Yes,No,Abort,Edit]? "
}

setprompt


##### External Programs

# use autojump if it's available
[[ -f $HOME/.autojump.zsh ]] && source $HOME/.autojump.zsh

# use ruby rbenv if it's available
command -v rbenv >/dev/null && eval "$(rbenv init -)"

# use python virtualenv if it's available
[[ ! -d $HOME/.virtualenvs ]] && mkdir "$HOME/.virtualenvs"
command -v virtualenvwrapper.sh >/dev/null && source virtualenvwrapper.sh

# invoke keychain to manage ssh/gpg keys
if [[ -x $(which keychain 2>/dev/null) ]]; then
	keychain --agents ssh --quick --quiet id_rsa
	[[ -f $HOME/.keychain/$HOST-sh ]] && source $HOME/.keychain/$HOST-sh
fi
