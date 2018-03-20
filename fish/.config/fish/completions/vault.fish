
function __complete_vault
    set -lx COMP_LINE (string join ' ' (commandline -o))
    test (commandline -ct) = ""
    and set COMP_LINE "$COMP_LINE "
    /nix/store/lv423g56bbild6d3l7x1d2xlm99j19pl-vault-0.9.4/bin/vault
end
complete -c vault -a "(__complete_vault)"

