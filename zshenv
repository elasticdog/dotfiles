#
# ~/.zshenv
#

export DISPLAY=':0.0'
export GOPATH="$HOME/src/go"
export PAGER='less -iM'
export WORKON_HOME="$HOME/.virtualenvs"

# set up amazon web services credentials
export AWS_CONFIG_FILE="$HOME/.aws/config"
if [[ -f $AWS_CONFIG_FILE ]]; then
	export AWS_ACCESS_KEY=$(awk -F= '/^aws_access_key_id/{ print $2 }' $AWS_CONFIG_FILE)
	export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY"
	export AWS_SECRET_KEY=$(awk -F= '/^aws_secret_access_key/{ print $2 }' $AWS_CONFIG_FILE)
	export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_KEY"
fi

command -v mvim >/dev/null && export EDITOR='mvim -v' || export EDITOR='vim'

unset MANPATH  # man does a better job on its own

typeset -U fpath path  # keep only the first occurrence of each duplicated value

fpath=($HOME/.zsh/completion $fpath)
case $OSTYPE in
	darwin*)
		export GOROOT='/usr/local/go'
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
