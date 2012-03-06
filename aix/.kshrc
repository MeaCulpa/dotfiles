###############################################################################
# -jyxu- xujinyu@cn.ibm.com
#       environment setup
        set -o bgnice
        set -o vi
        export LESS="-CdeiM"
        typeset PSPF="[$HOST] "


#       term setup
function ttyis
{       echo $* > /.ttytype
        TERM="$*"
	export TERM
}

#       directory commands
        alias tvi=/bos/k/bin/vi
        alias em="emacs =100x38+0+0"
        alias li="/bin/li -v"
        alias e="vi"
        alias smit="smitty"
        alias ec="errclear 0"
        alias 10="rlogin iovlab10 -l root"

#       system management commands
        alias tl="export TERM=vt320"
        alias t100="export TERM=vt100"
		alias gs='cd /gsa/ausgsa/projects/s/sift'
        alias ti="export TERM=vt320"
        alias cls="tput clear"
        alias mdt="cd /usr/lpp/htx/mdt"
        alias reg="cd /usr/lpp/htx/rules/reg"
        alias bin="cd /usr/lpp/htx/bin"
        alias pspg="ps -ef | pg"
	alias s="echo 'sync;sync;sync;sync';sync;sync;sync;sync"

#       miscellaneous commands
	alias de="daemon emacs"
        alias dx="daemon xant"

function xe
{       SAVDISP=$DISPLAY
        DISPLAY=""; export DISPLAY
        efile=`tpath $* 2>/dev/null`
        if [ -z "$efile" ]
        then /usr/bin/e $*
        else /usr/bin/e $efile
        fi
        DISPLAY=$SAVDISP; export DISPLAY
}

function ez
{       if [ $# -ne 0 ]
        then arg1=$1
             [ -f "$arg1.lstZ" ] || { echo "$arg1.lstZ not found."; return [1]; }
        fi
        if [ ! -f "$arg1.lstZ" ]
        then arg1=
             while [ -z "$arg1" ]
             do echo "Enter filename without suffix: \c"
                read arg1
             done
             [ -f "$arg1.lstZ" ] || { echo "$arg1.lstZ not found."; return [1]; }
        fi
        zcat $arg1.lstZ > /tmp/$arg1.list; chmod 444 /tmp/$arg1.list
        e /tmp/$arg1.list; rm -f /tmp/$arg1.list
}

######  Personal Stuff  ######
export PATH=$PATH:/opt/freeware/bin
PR_BUILD=${BR_BUILD:=`cat /usr/lpp/bos/aix_release.level`}
PS1=`logname`@`hostname`[$PR_BUILD]:'$PWD# '
export PS1
export TERM=vt100

set -o vi


