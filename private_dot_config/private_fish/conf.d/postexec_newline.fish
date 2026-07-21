# Add a blank line after each command's output, before the next prompt.
function postexec_newline --on-event fish_postexec
    echo
end
