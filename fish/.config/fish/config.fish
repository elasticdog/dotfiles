# set up amazon web services credentials
export-aws-creds default

set -l ATLAS_CREDENTIALS_FILE $HOME/.config/atlas
if test -f $ATLAS_CREDENTIALS_FILE
	set -x ATLAS_TOKEN (awk '/^atlas_token/{ print $3 }' $ATLAS_CREDENTIALS_FILE)
end

set -l HETZNER_CREDENTIALS_FILE $HOME/.config/hetzner
if test -f $ATLAS_CREDENTIALS_FILE
	set -x HETZNER_LOGIN (awk '/^hetzner_login/{ print $3 }' $HETZNER_CREDENTIALS_FILE)
	set -x HETZNER_PASSWORD (awk '/^hetzner_password/{ print $3 }' $HETZNER_CREDENTIALS_FILE)
end

# disable the shell greeting message
set -e fish_greeting

# use vi-style command line editing
fish_vi_mode
set -x GIT_EDITOR nvim

# set custom key bindings here until this is resolved:
# https://github.com/fish-shell/fish-shell/issues/1495
function my_vi_key_bindings
	fish_vi_key_bindings

	# bind Ctrl-l to clear the screen
	bind -M insert \cl 'clear; commandline -f repaint'
end
set -g fish_key_bindings my_vi_key_bindings

set -x GOPATH $HOME/src/go
set -x GOROOT /usr/local/go
set -x HOMEBREW_NO_ANALYTICS 1
set -x PATH $HOME/bin $HOME/.local/bin $HOME/.cargo/bin $PATH
set -x PYTHONPATH $HOME/src/vendor/vanilla/beancount/src/python

switch (uname)
	case Darwin
		set -x JAVA_HOME (/usr/libexec/java_home)
end

# add auto-expanding abbreviations
abbr -a g git
abbr -a gdiff "git diff --no-index --color --color-words"
abbr -a nix-shell "nix-shell --run fish"
abbr -a tree "tree -F --dirsfirst"

# http://direnv.net/
if command -s direnv >/dev/null
	eval (direnv hook fish)
end

if status --is-interactive; and test -d $HOME/.ssh/config.d
	compile-ssh-config
end
