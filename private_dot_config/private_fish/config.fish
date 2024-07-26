# disable the welcome message
set fish_greeting

# clear out the user paths and set them from scratch
set --erase --universal fish_user_paths
test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
test -d $HOME/.cargo/bin; and fish_add_path $HOME/.cargo/bin
test -d $HOME/.juliaup/bin; and fish_add_path $HOME/.juliaup/bin
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

# load direnv shell extension hooks
if type -q direnv
    direnv hook fish | source
end

# load google cloud sdk utilities
if test -d "$(brew --prefix)/Caskroom/google-cloud-sdk"
    source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end

if status is-interactive
    # use helix as the default editor
    set -x EDITOR hx

    # prefer using colors in output
    set -x CLICOLOR_FORCE 1

    # use fzf for fuzzy search shell integration
    if test -d "$(brew --prefix)/opt/fzf"
        source "$(brew --prefix)/opt/fzf/shell/key-bindings.fish"; and fzf_key_bindings

        set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git/ --exclude .jj/"
        set -x FZF_DEFAULT_OPTS "
            --exit-0
            --info=inline
            --margin=1,0,0,0"

        # ALT+C = change directory
        set -x FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git/ --exclude .jj/"
        set -x FZF_ALT_C_OPTS "
            --bind='?:toggle-preview'
            --preview='tree --dirsfirst --gitignore {} | head -128'"

        # CTRL+R = shell history
        set -x FZF_CTRL_R_OPTS "
            --bind='?:toggle-preview'
            --preview='echo {}'
            --preview-window='down:3:hidden:wrap'"

        # CTRL+T = file completion
        set -x FZF_CTRL_T_COMMAND "fd --hidden --follow --exclude .git/ --exclude .jj/ --search-path \$dir"
        set -x FZF_CTRL_T_OPTS "
            --bind='?:toggle-preview'
            --height=80%
            --preview='bat -n --color=always {} 2> /dev/null || tree -C --dirsfirst --gitignore {} | head -128'"
    end

    # when installed, configure homebrew
    if type -q brew; and test -f $HOME/.config/homebrew/Brewfile
        set -x HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
    end

    # when installed, configure ripgrep
    if type -q rg; and test -f $HOME/.config/ripgrep/ripgreprc
        set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc
    end

    # when installed, use secretive for ssh-agent auth
    if test -d $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/
        set -x SSH_AUTH_SOCK /Users/abs/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    end

    # add auto-expanding abbreviations
    abbr -a cz chezmoi
    abbr -a tree "tree --dirsfirst --gitignore"
    abbr -a x "cargo xtask"
end
