# gruvbox theme; dark mode with hard contrast
#
# https://github.com/dawikur/base16-gruvbox-scheme
# https://github.com/leira/base16-kakoune
# https://github.com/morhetz/gruvbox

evaluate-commands %sh{
    base00="rgb:1d2021"  # ----
    base01="rgb:3c3836"  # ---
    base02="rgb:504945"  # --
    base03="rgb:665c54"  # -
    base04="rgb:bdae93"  # +
    base05="rgb:d5c4a1"  # ++
    base06="rgb:ebdbb2"  # +++
    base07="rgb:fbf1c7"  # ++++
    base08="rgb:fb4934"  # red
    base09="rgb:fe8019"  # orange
    base0A="rgb:fabd2f"  # yellow
    base0B="rgb:b8bb26"  # green
    base0C="rgb:8ec07c"  # aqua/cyan
    base0D="rgb:83a598"  # blue
    base0E="rgb:d3869b"  # purple
    base0F="rgb:d65d0e"  # brown

    ## code
    echo "
        face global value ${base09}
        face global type ${base0A}
        face global variable ${base08}
        face global module ${base08}
        face global function ${base0D}
        face global string ${base0B}
        face global keyword ${base0E}
        face global operator ${base05}
        face global attribute ${base0C}
        face global comment ${base03}
        face global meta ${base0F}
        face global builtin ${base0D}+b
    "

    ## markup
    echo "
        face global title ${base0D}+b
        face global header ${base0D}
        face global bold ${base0A}+b
        face global italic ${base0E}+i
        face global mono ${base0B}
        face global block ${base0C}
        face global link ${base09}
        face global bullet ${base08}
        face global list ${base08}
    "

    ## builtin
    echo "
        face global Default ${base05},${base00}
        face global PrimarySelection default,${base02}+g
        face global SecondarySelection ${base04},${base01}
        face global PrimaryCursor ${base00},${base05}
        face global SecondaryCursor ${base00},${base03}+fg
        face global PrimaryCursorEol default,${base0D}
        face global SecondaryCursorEol default,${base03}
        face global MenuForeground ${base00},${base0D}
        face global MenuBackground ${base05},${base01}
        face global MenuInfo ${base02},default
        face global Information ${base01},${base04}
        face global Error ${base00},${base08}
        face global StatusLine ${base04},${base01}
        face global StatusLineMode ${base0B},default
        face global StatusLineInfo ${base0D},default
        face global StatusLineValue ${base0C},default
        face global StatusCursor ${base01},${base0D}
        face global Prompt ${base0D},${base01}
        face global BufferPadding ${base01},default
        face global LineNumbers ${base02},${base00}
        face global LineNumberCursor ${base0A},${base00}
        face global MatchingChar default,${base02}
        face global Whitespace ${base01},default+f
    "
}
