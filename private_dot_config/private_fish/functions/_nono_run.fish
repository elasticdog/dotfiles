# Shared backend for the nono* agent wrappers. Mirrors nono's own syntax:
#
#   _nono_run [nono options] -- COMMAND [command args]
#
# Options before `--` are baked in by the wrapper: the agent's --profile,
# which nono only allows one of, so treat it as the agent's fixed identity.
# Per-project context is layered on through $NONO_OPTS with --extends
# (repeatable) and other flags, set via direnv, mise.local.toml, or similar.
# Everything after COMMAND is passed straight through to the agent.
#
# $NONO_OPTS is split naively on whitespace: fine for flag values without
# embedded spaces (--extends bases, paths, domains). Don't put --profile here,
# the baked one is authoritative and nono rejects a second; use --extends to
# layer instead.
#
# https://nono.sh/
function _nono_run --description "run a command inside a nono sandbox with per-project opts from the env"
    set -l sep (contains -i -- -- $argv)
    if test -z "$sep"
        echo "_nono_run: expected '--' between nono options and the command" >&2
        return 2
    end

    set -l baked_opts
    test $sep -gt 1; and set baked_opts $argv[1..(math $sep - 1)]

    set -l cmd_argv $argv[(math $sep + 1)..-1]
    if not set -q cmd_argv[1]
        echo "_nono_run: no command given after '--'" >&2
        return 2
    end

    set -l cmd $cmd_argv[1]
    set -e cmd_argv[1]

    set -l base_opts (string split -n ' ' -- $NONO_OPTS)

    nono run --allow-cwd $baked_opts $base_opts -- $cmd $cmd_argv
end
