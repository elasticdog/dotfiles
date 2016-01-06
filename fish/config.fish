# set up amazon web services credentials
export-aws-creds default

set -l ATLAS_CREDENTIALS_FILE $HOME/.config/atlas
if test -f $ATLAS_CREDENTIALS_FILE
	set -x ATLAS_TOKEN (awk '/^atlas_token/{ print $3 }' $ATLAS_CREDENTIALS_FILE)
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
set -x PATH $HOME/bin $HOME/.nimble/bin $PATH
set -x PYTHONPATH $HOME/src/vendor/vanilla/beancount/src/python

# add auto-expanding abbreviations
abbr -a g git
abbr -a gdiff "git diff --no-index --color --color-words"
abbr -a tree "tree -F --dirsfirst"

## NIX SETUP
#
#set -x NIX_LINK $HOME/.nix-profile
#
## Set the default profile.
#if not test -L $NIX_LINK
#	printf 'creating %s\n' $NIX_LINK >&2
#	set -l _NIX_DEF_LINK /nix/var/nix/profiles/default
#	/nix/store/cdybb3hbbxf6k84c165075y7vkv24vm2-coreutils-8.23/bin/ln -s "$_NIX_DEF_LINK" "$NIX_LINK"
#end
#
#set -U fish_user_paths $NIX_LINK/bin $NIX_LINK/sbin
#
## Subscribe the user to the Nixpkgs channel by default.
#if not test -e $HOME/.nix-channels
#	echo "https://nixos.org/channels/nixpkgs-unstable nixpkgs" > $HOME/.nix-channels
#end
#
## Append ~/.nix-defexpr/channels/nixpkgs to $NIX_PATH so that
## <nixpkgs> paths work when the user has fetched the Nixpkgs
## channel.
#set -x NIX_PATH $NIX_PATH $HOME/src/vendor/vanilla/nixpkgs nixpkgs=$HOME/src/vendor/vanilla/nixpkgs /nix/var/nix/profiles/per-user/aaron/channels/nixos
#
## Set $SSL_CERT_FILE so that Nixpkgs applications like curl work.
#if test -e /etc/ssl/certs/ca-bundle.crt                    # Fedora, NixOS
#	set -x SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
#else if test -e /etc/ssl/certs/ca-certificates.crt         # Ubuntu, Debian
#	set -x SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
#else if test -e "$NIX_LINK/etc/ca-bundle.crt"              # fall back to Nix profile
#	set -x SSL_CERT_FILE "$NIX_LINK/etc/ca-bundle.crt"
#end
