#
# ~/.zshenv
#

export DISPLAY=':0.0'
export GOPATH="${HOME}/src/go"
export PAGER='less -iM'
export WORKON_HOME="$HOME/.virtualenvs"

command -v mvim >/dev/null && export EDITOR='mvim -v' || export EDITOR='vim'

unset MANPATH  # man does a better job on its own

typeset -U fpath path  # keep only the first occurrence of each duplicated value

fpath=($HOME/.zsh/completion $fpath)
case $OSTYPE in
	darwin*)
		export GOROOT='/usr/local/Cellar/go/HEAD'
		path=($HOME/bin $GOPATH/bin /usr/local/bin /usr/local/sbin $path)
		;;
	linux*)
		export GOROOT="${HOME}/src/vendor/vanilla/go"
		if [[ -d $HOME/.rbenv/bin ]]; then
			path=($HOME/bin $GOPATH/bin $HOME/.rbenv/bin /usr/local/bin /usr/local/sbin $path)
		else
			path=($HOME/bin $GOPATH/bin /usr/local/bin /usr/local/sbin $path)
		fi
		;;
esac
