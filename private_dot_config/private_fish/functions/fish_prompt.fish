function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color -b d3d4d4)(set_color brred)"$USER"(set_color a0a1a7)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color -b d3d4d4)(set_color 595e64)' '(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color -b normal)(set_color d3d4d4)' '
    set_color normal
end
