# disable the welcome message
set fish_greeting

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
    set -x LS_COLORS 'di=38;5;12:ln=38;5;14:so=38;5;6:pi=38;5;6:ex=38;5;2;1:bd=38;5;3:cd=38;5;3:su=38;5;1:sg=38;5;1:tw=38;5;1:ow=38;5;1:or=38;5;1:mi=38;5;1:fi=0:*.tar=38;5;9:*.tgz=38;5;9:*.zip=38;5;9:*.gz=38;5;9:*.bz2=38;5;9:*.xz=38;5;9:*.7z=38;5;9:*.jpg=38;5;13:*.jpeg=38;5;13:*.png=38;5;13:*.gif=38;5;13:*.svg=38;5;13:*.webp=38;5;13:*.mp3=38;5;5:*.wav=38;5;5:*.flac=38;5;5:*.mp4=38;5;5:*.mkv=38;5;5:*.mov=38;5;5:*.pdf=38;5;4:*.md=38;5;8:*.txt=38;5;8'

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

    # when installed, configure ripgrep
    if type -q rg; and test -f $HOME/.config/ripgrep/ripgreprc
        set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc
    end

    # add auto-expanding abbreviations
    abbr -a cz chezmoi
    abbr -a tree "tree --dirsfirst --gitignore"
    abbr -a x "cargo xtask"
end
