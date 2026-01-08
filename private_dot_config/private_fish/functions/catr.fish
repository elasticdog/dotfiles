function catr --description "Recursively cat files/dirs with cwd-relative headers (canonical paths), NUL-safe, unsorted (macOS)"
    set -l args $argv
    if test (count $args) -eq 0
        set args .
    end

    # Physical cwd (resolves symlinks)
    set -l cwd_phys (pwd -P)

    function __catr_print --no-scope-shadowing
        set -l raw $argv[1]

        # Canonical absolute path (BSD realpath). If realpath fails, skip.
        set -l abs (command realpath -- $raw 2>/dev/null)
        if test $status -ne 0 -o -z "$abs"
            printf "catr: skipping (cannot realpath): %s\n" $raw >&2
            return 1
        end

        # Header: make it relative to cwd_phys when possible
        set -l hdr $abs
        if string match -q -- "$cwd_phys/*" $abs
            set hdr (string replace -r "^"(string escape --style=regex -- $cwd_phys)"/" '' -- $abs)
        else if test "$abs" = "$cwd_phys"
            set hdr .
        end

        printf "\n===== %s =====\n" $hdr
        cat -- $abs
    end

    for a in $args
        if test -f $a
            __catr_print $a
        else if test -d $a
            fd -t f -0 . $a |
                while read -lz f
                    __catr_print $f
                end
        else
            printf "catr: skipping (not found or not a regular file/dir): %s\n" $a >&2
        end
    end

    functions -e __catr_print
end
