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

autoload -U colors ; colors
zstyle -e ':completion:*' list-colors 'thingy=${PREFIX##*/} reply=( "=(#b)($thingy)(?)*=00=$color[green]=$color[bold]" )'

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

setopt share_history         # use common history file for all sessions
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
		alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
		alias ls='ls -GF'                # list in color with identifiers
		if [[ -x $(which mvim 2>/dev/null) ]]; then
			alias gvimdiff='mvim -d -g'  # use MacVim for gvimdiff
			alias vim='mvim -v'          # use MacVim for terminal vim
		fi
		alias pg_ctl='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
		alias postgres='postgres -D /usr/local/var/postgres'

		# force all traffic through an ssh tunnel to my VPS
		# useful when using insecure wireless connections
		if [[ -x $(which sshuttle 2>/dev/null) ]]; then
			alias tunnel='sshuttle --daemon --dns --pidfile=/tmp/sshuttle.pid --remote=linode 0/0'
			alias tunnelx='[[ -f /tmp/sshuttle.pid ]] && kill $(cat /tmp/sshuttle.pid) && echo "Disconnected."'
		fi
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
for command in cp git knife mkdir mv ssh; do
	alias $command="nocorrect $command"
done

# no globbing for these commands
for command in bundle git rake; do
	alias $command="noglob $command"
done

# make gpg2 use gpg autocompletion (not ideal, but it works for the basics)
compdef gpg2=gpg

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

# perform a directory diff comparison
alias ddiff='diff -rq'

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

# alternative duv?
# du --max-depth=1 -x | sort -r -n | awk '{split("k m g",v); s=1; while($1>1024){$1/=1024; s++} print int($1)" "v[s]"\t"$2}'

# another alternative?
# function duv {
# du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
# }

alias humanize="awk '{ split( \"B KB MB GB TB PB\" , unit ); s=1; while( \$1>1000 ){ \$1/=1000; s++ } printf \"%6.1f %s  %s\n\", \$1, unit[s], \$2 }'"

# remove duplicate lines in a file without sorting
alias nodups="awk '!x[\$0]++'"

# shortcut for optipng's most exhaustive search
[[ -x $(which optipng 2>/dev/null) ]] && alias optimax='optipng -zc1-9 -zm1-9 -zs0-3 -f0-5'

# remove color escape codes from output
alias rc='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

# use a more portable $TERM value when in tmux and connecting to a remote machine
[[ -n $TMUX ]] && alias ssh='TERM="xterm-256color" ssh'

# ssh without using known_hosts protection
alias sshkh='ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# scp without using known_hosts protection
alias scpkh='scp -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# ssh/scp using work configuration file
alias sshw='ssh -F ~/.ssh/mnx-config'
alias scpw='scp -F ~/.ssh/mnx-config'

# web cat
[[ -x $(which wget 2>/dev/null) ]] && alias wcat='wget -q -O - '

### git aliases

alias g='git'

# change into git repo's top-level directory
alias gcd='cd $(git rev-parse --show-toplevel)'

alias gmup='master_update'
alias gmpu='master_push'
alias gsyn='sync_repo'
alias gbcr='branch_create'
alias gbup='branch_update'
alias gblg='branch_log'
alias gbdf='branch_diff'
alias gbmg='branch_merge'
alias gbbm='big_branch_merge'


##### Global Aliases

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -g A='| column -t'
alias -g B='bundle exec'
alias -g C='clear && '
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g N='> /dev/null 2>&1'
alias -g P='ps aux | head -1 && ps aux | grep -v grep | grep'
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
		echo 'SSH and automatically attach to or start a GNU screen session on the remote server'
	else
		ssh -t $* screen -DRU
	fi
}

# ssh and attach to or start a tmux session on the remote server
function ssht {
	if [[ -z $* ]]; then
		echo 'Usage: ssht [options] [user@]hostname'
		echo 'SSH and automatically attach to or start a tmux session on the remote server'
	else
		ssh -t $* tmuxx
	fi
}

### git functions

git_environment_vars() {
	CURRENT_BRANCH="$(git symbolic-ref -q HEAD)"
	CURRENT_BRANCH="${CURRENT_BRANCH#refs/heads/}"
	TOPLEVEL_DIR="$(git rev-parse --show-toplevel)"
	WORKING_DIR="$PWD"
}

master_update() {
	if git config --get 'branch.master.remote'; then
		git_environment_vars
		cd "$TOPLEVEL_DIR"
		git checkout master
		git pull --rebase
		git checkout "$CURRENT_BRANCH"
		cd "$WORKING_DIR"
	fi
}

master_push() {
	if git config --get 'branch.master.remote'; then
		git_environment_vars
		cd "$TOPLEVEL_DIR"
		git checkout master
		git push
		git checkout "$CURRENT_BRANCH"
		cd "$WORKING_DIR"
	fi
}

sync_repo() {
	master_update
	master_push
}

branch_create() {
	if [[ -z $1 ]]; then
		echo 'Usage: branch_create <branchname>'
		echo 'Creates a new branch named <branchname> with master as its start point'
	else
		git checkout -b "$1" master
	fi
}

branch_update() {
	master_update
	git rebase master
}

# most commonly used; squash all branch commits into one
branch_merge() {
	if branch_update; then
		git_environment_vars
		cd "$TOPLEVEL_DIR"
		git checkout master
		# validate that the merge happens since we have to forcefully delete the branch
		if git merge --ff-only --squash "$CURRENT_BRANCH"; then
			git commit --verbose --edit -m "$(echo "Squashed commit of the following:\n\n$(git log master..${CURRENT_BRANCH} --pretty=format:'    * %ad %h - %s' --date=short)")"
			git branch -D "$CURRENT_BRANCH"
		fi
		cd "$WORKING_DIR"
	fi
}

# used for bigger branches; allows you to manually squash/fixup
# branch commits into smaller, more logical/manageable chunks
big_branch_merge() {
	if branch_update; then
		git_environment_vars
		cd "$TOPLEVEL_DIR"
		git rebase --interactive --autosquash master
		git checkout master
		git merge --no-ff --no-commit "$CURRENT_BRANCH"
		git commit
		cd "$WORKING_DIR"
	fi
}

branch_log() {
	git_environment_vars
	echo "Commits in branch \"${CURRENT_BRANCH}\", but not \"master\":"
	git log master..${CURRENT_BRANCH} --pretty=format:'%C(yellow)%h%C(green)%d%C(reset) %s %C(cyan)[%cr]%C(reset)' --graph --date=relative -M -C
}

branch_diff() {
	git_environment_vars
	echo "Commits in branch \"${CURRENT_BRANCH}\", but not \"master\":"
	git diff master..${CURRENT_BRANCH}
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

# load Go lang settings/completion if it's available
[[ -f $GOROOT/share/zsh/site-functions/_go ]] && source $GOROOT/share/zsh/site-functions/_go

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
