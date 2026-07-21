# disable the welcome message
set fish_greeting

fish_config theme choose catppuccin-macchiato

# clear out the user paths and set them from scratch
set --erase --universal fish_user_paths
test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
test -d $HOME/.cargo/bin; and fish_add_path $HOME/.cargo/bin
test -d $HOME/.juliaup/bin; and fish_add_path $HOME/.juliaup/bin
test -d $HOME/.pub-cache/bin; and fish_add_path $HOME/.pub-cache/bin
test -d $HOME/Library/Android/sdk/cmdline-tools/latest/bin; and fish_add_path $HOME/Library/Android/sdk/cmdline-tools/latest/bin
test -d $HOME/Library/Android/sdk/emulator; and fish_add_path $HOME/Library/Android/sdk/emulator
test -d $HOME/Library/Android/sdk/platform-tools; and fish_add_path $HOME/Library/Android/sdk/platform-tools
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

# load google cloud sdk utilities
if test -d "$(brew --prefix)/Caskroom/google-cloud-sdk"
    source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end

if status is-interactive
    bind \cz __fg_or_undo

    # use helix as the default editor
    set -x EDITOR hx

    # prefer using colors in output
    set -x CLICOLOR_FORCE 1
    set -x LS_COLORS (vivid generate catppuccin-macchiato)

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
            --preview='eza -Ta --classify=always --color=always --group-directories-first --git-ignore {} | head -128'"

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
            --preview='bat -n --color=always {} 2> /dev/null || eza -Ta --classify=always --color=always --group-directories-first --git-ignore {} | head -128'"
    end

    # when installed, configure zmx-picker
    if type -q zp
        set -gx ZP_ROOT $HOME/src

        # bind Ctrl-\ to zp when not inside a zmx session;
        # inside zmx, Ctrl-\ detaches the current session
        if not set -q ZMX_SESSION
            bind ctrl-\\ 'zp; commandline -f execute'
        end
    end

    # when installed, configure homebrew
    if type -q brew; and test -f $HOME/.config/homebrew/Brewfile
        set -x HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
    end

    # when installed, configure nono
    if type -q nono
        set -x NONO_THEME macchiato
    end

    # when installed, configure ripgrep
    if type -q rg; and test -f $HOME/.config/ripgrep/ripgreprc
        set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc
    end

    # add auto-expanding abbreviations
    abbr -a cz chezmoi
    abbr -a x "cargo xtask"

    # aliases
    alias ls='eza --hyperlink=auto'
    alias ll='eza -lag --icons --git --group-directories-first --hyperlink=auto'
    alias lt='eza -Ta --classify=always --color=always --group-directories-first --git-ignore --hyperlink=auto'
    alias li='y'
end
