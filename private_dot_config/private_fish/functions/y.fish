function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if test -f "$tmp"
        set cwd (cat "$tmp")
        rm "$tmp"
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd "$cwd"
        end
    end
end
