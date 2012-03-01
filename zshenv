#
# ~/.zshenv
#

export DISPLAY=':0.0'
export PAGER='less -iM'

command -v mvim >/dev/null && export EDITOR='mvim -v' || export EDITOR='vim'

export CVSROOT='aarons@cvs:/cvs'
export CVS_RSH='ssh'

export WORKON_HOME="$HOME/.virtualenvs"

unset MANPATH  # man does a better job on its own

# Various profile/rc/login files all get sourced *after* this file, so we
# source our path file here (for non-login shells) and from .zprofile (which is
# only sourced for login shells).
source $HOME/.zpath
