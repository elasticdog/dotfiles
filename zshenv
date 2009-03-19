#
# ~/.zshenv
#

export BROWSER='firefox'
export DISPLAY=':0.0'
export EDITOR='vim'
export PAGER='less -iM'

unset MANPATH  # man does a better job on its own

typeset -U path  # keep only the first occurrence of each duplicated value
case $OSTYPE in
	darwin*)
		path=(${HOME}/bin /opt/local/bin /opt/local/sbin /usr/local/bin $path)
		;;
	linux*)
		path=(${HOME}/bin $path)

		# Arch Linux
		if [[ -f /etc/arch-release ]] then
			export CVSROOT=":pserver:elasticdog@cvs.archlinux.org:/home/cvs-community"
		fi
		;;
esac
