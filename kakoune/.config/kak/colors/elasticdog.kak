evaluate-commands %sh{
    ###################### ----- white
    base00="rgb:edeeef"  # ----  background
    base01="rgb:e0e1e1"  # ---
    base02="rgb:d3d4d4"  # --
    base03="rgb:c6c7c7"  # -     light gray
    base04="rgb:a0a1a7"  # +     dark gray
    base05="rgb:7c7e85"  # ++
    base06="rgb:595e64"  # +++
    base07="rgb:393f46"  # ++++  foreground
    ###################### +++++ black

    black="rgb:1b2229"
    black_bright="rgb:a0a1a7" # dark gray
    red="rgb:e45649"
    red_bright="rgb:dd8844" # orange
    green="rgb:50a14f"
    green_bright="rgb:44b9b1"
    yellow="rgb:c5a332"
    yellow_bright="rgb:c0d9f2" # baby blue
    blue="rgb:275fe4"
    blue_bright="rgb:0098dd"
    magenta="rgb:a626a4"
    magenta_bright="rgb:823ff1" # violet
    cyan="rgb:005478"
    cyan_bright="rgb:0078ab"
    white="rgb:c6c7c7"        # light gray
    white_bright="rgb:fafbfc" # white

    ## code
    echo "
        face global value ${red_bright}
        face global type ${yellow}
        face global variable ${red}
        face global module ${red}
        face global function ${blue}
        face global string ${green}
        face global keyword ${magenta}
        face global operator ${base05}
        face global attribute ${cyan}
        face global comment ${base04}+i
        face global meta ${magenta_bright}
        face global builtin ${blue}+b
    "

    ## markup
    echo "
        face global title ${cyan_bright}+b
        face global header ${cyan}
        face global bold ${yellow}+b
        face global italic ${magenta}+i
        face global mono ${green}
        face global block ${cyan}
        face global link ${red_bright}
        face global bullet ${red}
        face global list ${red}
    "

    ## builtin
    echo "
        face global Default ${base07},${base00}
        face global PrimarySelection ${base06},${yellow_bright}+fg
        face global SecondarySelection ${base05},${base01}+fg
        face global PrimaryCursor ${base00},${blue_bright}+fg
        face global SecondaryCursor ${base05},${yellow_bright}+fg
        face global PrimaryCursorEol ${base03},${blue_bright}+fg
        face global SecondaryCursorEol ${base01},${base03}+fg
        face global MenuForeground ${base00},${cyan}
        face global MenuBackground ${base05},${base01}
        face global MenuInfo ${base02},default
        face global Information ${base04},${base01}
        face global Error ${base00},${red}
        face global StatusLine ${base05},${base01}
        face global StatusLineMode ${green},default
        face global StatusLineInfo ${magenta_bright},default
        face global StatusLineValue ${cyan},default
        face global StatusCursor ${base01},${blue_bright}
        face global Prompt ${cyan_bright},${base01}
        face global BufferPadding ${base01},default
        face global LineNumbers ${base03},${base00}
        face global LineNumberCursor ${base04},${base00}+b
        face global MatchingChar default,${base01}+b
        face global Whitespace ${base01},default+f
    "
}
