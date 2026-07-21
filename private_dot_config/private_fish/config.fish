# disable the welcome message
set -g fish_greeting

# use helix as the default editor
set -gx EDITOR hx

# cache the prefix once instead of spawning `brew --prefix` repeatedly
set -l brew_prefix /opt/homebrew

# build the user paths from scratch each session, global (not universal) so
# nothing is persisted to fish_variables and precedence stays deterministic
for dir in \
    $brew_prefix/bin \
    $HOME/.cargo/bin \
    $HOME/.juliaup/bin \
    $HOME/.pub-cache/bin \
    $HOME/Library/Android/sdk/cmdline-tools/latest/bin \
    $HOME/Library/Android/sdk/emulator \
    $HOME/Library/Android/sdk/platform-tools \
    $HOME/.local/bin \
    $HOME/bin
    test -d $dir; and fish_add_path -g $dir
end

# load google cloud sdk utilities
if test -d "$brew_prefix/Caskroom/google-cloud-sdk"
    source "$brew_prefix/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end

if status is-interactive
    fish_config theme choose catppuccin-macchiato

    bind \cz __fg_or_undo

    # git prompt styling (set once here, not on every prompt redraw)
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_color_branch_detached purple
    set -q fish_color_status; or set -g fish_color_status red

    # prefer using colors in output
    set -gx CLICOLOR_FORCE 1
    set -gx LS_COLORS (vivid generate catppuccin-macchiato)

    # use fzf for fuzzy search shell integration
    if type -q fzf
        fzf --fish | source

        set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git/ --exclude .jj/"
        set -gx FZF_DEFAULT_OPTS "
            --exit-0
            --info=inline
            --margin=1,0,0,0"

        # ALT+C = change directory
        set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git/ --exclude .jj/"
        set -gx FZF_ALT_C_OPTS "
            --bind='?:toggle-preview'
            --preview='eza -TaF --color=always --group-directories-first --git-ignore {} | head -128'"

        # CTRL+R = shell history
        set -gx FZF_CTRL_R_OPTS "
            --bind='?:toggle-preview'
            --preview='echo {}'
            --preview-window='down:3:hidden:wrap'"

        # CTRL+T = file completion
        set -gx FZF_CTRL_T_COMMAND "fd --hidden --follow --exclude .git/ --exclude .jj/ --search-path \$dir"
        set -gx FZF_CTRL_T_OPTS "
            --bind='?:toggle-preview'
            --height=80%
            --preview='bat -n --color=always {} 2> /dev/null || eza -TaF --color=always --group-directories-first --git-ignore {} | head -128'"
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
        set -gx HOMEBREW_BUNDLE_FILE $HOME/.config/homebrew/Brewfile
    end

    # when installed, configure nono
    if type -q nono
        set -gx NONO_THEME macchiato
    end

    # when installed, configure ripgrep
    if type -q rg; and test -f $HOME/.config/ripgrep/ripgreprc
        set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc
    end

    # add auto-expanding abbreviations
    abbr -a cz chezmoi
    abbr -a x "cargo xtask"

    # command aliases
    alias ls='eza --hyperlink=auto'
    alias ll='eza -lag --icons --git --group-directories-first --hyperlink=auto'
    alias li='y'
    alias lt='eza -TaF --color=always --group-directories-first --git-ignore --hyperlink=auto'
    alias tree='eza -TaF --color=always --group-directories-first --git-ignore --hyperlink=auto'
end
