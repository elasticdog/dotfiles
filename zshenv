#
# ~/.zshenv
#

export BROWSER='firefox'
export DISPLAY=':0.0'
export EDITOR='/usr/bin/vim'
export PAGER='less -iM'

export CVSROOT='aarons@cvs:/cvs'
export CVS_RSH='ssh'

unset MANPATH  # man does a better job on its own

# Various profile/rc/login files all get sourced *after* this file, so we
# source our path file here (for non-login shells) and from .zprofile (which is
# only sourced for login shells).
source $HOME/.zpath
