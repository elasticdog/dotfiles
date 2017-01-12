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
set -g fish_key_bindings fish_vi_key_bindings

# http://direnv.net/
if command -s direnv >/dev/null
	eval (direnv hook fish)
end

set -x GIT_EDITOR nvim
set -x GOPATH $HOME/src/go
set -x GOROOT /usr/local/go
set -x HOMEBREW_NO_ANALYTICS 1
set -x PATH $HOME/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/.mix/escripts $PATH
set -x PYTHONPATH $HOME/src/vendor/vanilla/beancount/src/python
set -x VAULT_ADDR https://secrets.elastic.co:8200

switch (uname)
	case Darwin
		set -x JAVA_HOME (/usr/libexec/java_home)
end

# add auto-expanding abbreviations
abbr -a g git
abbr -a gdiff "git diff --no-index --color --color-words"
abbr -a nix-shell "nix-shell --run fish"
abbr -a tree "tree -F --dirsfirst"

# load asdf extendable version manager shims
if test -d $HOME/.asdf
	source ~/.asdf/asdf.fish
end

if status --is-interactive; and test -d $HOME/.ssh/config.d
	compile-ssh-config
end
