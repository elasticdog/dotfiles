#
# ~/.zshenv
#

export DISPLAY=':0.0'
export GOPATH="${HOME}/projects/gocode"
export GOROOT='/usr/local/Cellar/go/HEAD'
export PAGER='less -iM'
export WORKON_HOME="$HOME/.virtualenvs"

command -v mvim >/dev/null && export EDITOR='mvim -v' || export EDITOR='vim'

unset MANPATH  # man does a better job on its own

typeset -U fpath path  # keep only the first occurrence of each duplicated value

fpath=($HOME/.zsh/completion $fpath)
case $OSTYPE in
	darwin*)
		path=($HOME/bin $GOPATH/bin /usr/local/bin /usr/local/sbin /usr/local/share/python $path)
		;;
	linux*)
		if [[ -d $HOME/.rbenv/bin ]]; then
			path=($HOME/bin $HOME/.rbenv/bin /usr/local/bin /usr/local/sbin $path)
		else
			path=($HOME/bin /usr/local/bin /usr/local/sbin $path)
		fi
		;;
esac
