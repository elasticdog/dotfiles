function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -l vcs_color (set_color brpurple)
    set -l suffix_color (set_color f4a261) # Pink
    set -q fish_color_status
    or set -g fish_color_status red

    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_color_branch_detached purple

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus " " "" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -s (set_color $color_cwd) (prompt_pwd) $normal (fish_git_prompt " on$vcs_color  %s") $normal " "$prompt_status
    echo -n -s $suffix_color $suffix " "

    # Add a blank line after execution output before the next prompt
    source $HOME/.config/fish/functions/postexec_newline.fish
end
