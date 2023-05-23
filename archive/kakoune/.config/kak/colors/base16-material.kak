# material theme
#
# https://github.com/ntpeters/base16-materialtheme-scheme
# https://github.com/leira/base16-kakoune
# https://github.com/mawww/kakoune/blob/master/colors/base16.kak
# https://github.com/equinusocio/material-theme

evaluate-commands %sh{
    base00="rgb:263238"  # ----
    base01="rgb:2E3C43"  # ---
    base02="rgb:314549"  # --
    base03="rgb:546E7A"  # -
    base04="rgb:B2CCD6"  # +
    base05="rgb:EEFFFF"  # ++
    base06="rgb:EEFFFF"  # +++
    base07="rgb:FFFFFF"  # ++++
    base08="rgb:F07178"  # red
    base09="rgb:F78C6C"  # orange
    base0A="rgb:FFCB6B"  # yellow
    base0B="rgb:C3E88D"  # green
    base0C="rgb:89DDFF"  # aqua/cyan
    base0D="rgb:82AAFF"  # blue
    base0E="rgb:C792EA"  # purple
    base0F="rgb:FF5370"  # brown

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
        face global comment ${base03}+i
        face global meta ${base0F}
        face global builtin ${base0D}+b
    "

    ## markup
    echo "
        face global title ${base0D}+b
        face global header ${base0C}
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
        face global PrimarySelection ${base05},${base0D}+fg
        face global SecondarySelection ${base00},${base0D}+fg
        face global PrimaryCursor ${base00},${base05}+fg
        face global SecondaryCursor ${base00},${base05}+fg
        face global PrimaryCursorEol default,${base0D}+fg
        face global SecondaryCursorEol default,${base03}+fg
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
        face global LineNumbers ${base03},${base00}
        face global LineNumberCursor ${base0A},${base00}+b
        face global MatchingChar default,${base03}+b
        face global Whitespace ${base02},default+f
    "
}
