function __fg_or_undo
    if test -z (commandline)
        fg 2>/dev/null
        commandline -f repaint
    else
        commandline -f undo
    end
end
