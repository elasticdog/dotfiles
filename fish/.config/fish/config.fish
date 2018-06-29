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

set -x AWS_PROFILE default
set -x GIT_EDITOR nvim
set -x GOPATH $HOME/src/go
set -x PATH $HOME/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/src/go/bin $PATH
set -x VAULT_ADDR https://secrets.elastic.co:8200
set -x VISUAL nvim

switch (uname)
	case Darwin
		set -x HOMEBREW_NO_ANALYTICS 1
		set -x JAVA_HOME (/usr/libexec/java_home 2> /dev/null)
end

# add auto-expanding abbreviations
abbr -a duv "du -hs ./* | sort -hs"
abbr -a g "git"
abbr -a ga "git add"
abbr -a gap "git add --patch"
abbr -a gb "git branch"
abbr -a gci "git commit"
abbr -a gco "git checkout"
abbr -a gcob "git checkout -b"
abbr -a gd "git diff"
abbr -a gdiff "git diff --no-index --color --color-words"
abbr -a gp "git push"
abbr -a gpf "git push --force-with-lease"
abbr -a gpu "git pull --rebase"
abbr -a gr "git reset"
abbr -a grb "git rebase"
abbr -a grbi "git rebase --interactive --autosquash"
abbr -a gs "git status"
abbr -a gss "git status --short --branch"
abbr -a gst "git diff --cached"
abbr -a nix-shell "nix-shell --run fish"
abbr -a sshf "ssh -F ssh_config"
abbr -a tree "tree -F --dirsfirst"

# load asdf extendable version manager shims
if test -d $HOME/.asdf
	source ~/.asdf/asdf.fish
end

# load google cloud sdk utilities
if test -d $HOME/.local/google-cloud-sdk
	source $HOME/.local/google-cloud-sdk/path.fish.inc
end

# http://direnv.net/
if command -qs direnv
	eval (direnv hook fish)
end

if status --is-interactive; and test -d $HOME/.ssh/config.d
	compile-ssh-config
end
