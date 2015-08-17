# set up amazon web services credentials
set -x AWS_CONFIG_FILE $HOME/.aws/credentials
if test -f $AWS_CONFIG_FILE
	set -x AWS_ACCESS_KEY (awk -F= '/^aws_access_key_id/{ print $2 }' $AWS_CONFIG_FILE)
	set -x AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY
	set -x AWS_SECRET_KEY (awk -F= '/^aws_secret_access_key/{ print $2 }' $AWS_CONFIG_FILE)
	set -x AWS_SECRET_ACCESS_KEY $AWS_SECRET_KEY
end

# disable the shell greeting message
set -e fish_greeting

set -x GOPATH $HOME/src/go
set -x GOROOT /usr/local/go
set -x PATH $HOME/bin $HOME/.nimble/bin $PATH
set -x PYTHONPATH $HOME/src/vendor/vanilla/beancount/src/python


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
