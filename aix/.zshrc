#!/bin/zsh
###############################################################################
# -jyxu- xujinyu@cn.ibm.com

source /etc/profile

###############################################################################
# Variables
# ENV
export HISTFILE=~/.sh_history
export HISTSIZE=10000
export SAVEHIST=10000 

# Other
WORDCHARS='*?_-[]~=&;!#$%^(){}<>' # chars as part of filename

###############################################################################
# completion
autoload -U compinit
compinit

###############################################################################
# options
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE 
#setopt correctall
setopt correct
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd
setopt extendedglob # With this we can use cp ^*.(tar|bz2|gz)
#set -o vi # vi mode

###############################################################################
# Styles
# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd
# Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'
zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*:*:default' force-list always

[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"
#zmodload  zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command 'ps -au$USER'
# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
compdef pkill=kill
compdef pkill=killall

###############################################################################
# prompt
# Complex prompt
#export PS1="[%* - %D] %d %% "
autoload -U promptinit
promptinit
setprompt () {
    # load some modules
    autoload -U colors zsh/terminfo # Used in the colour alias below
    colors
    setopt prompt_subst

    # MAKE Some aliases for the colours: (coud use normal escap.seq's too)
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$fg[${(L)color}]%}'
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"

    # Check the UID
    if [[ $UID -ge 1000 ]]; then # normal user
        eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
        eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
    elif [[ $UID -eq 0 ]]; then # root
        eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
        eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
    fi    

    # Check if we are on SSH or not  --{FIXME}--  always goes to |no SSH|
    if [[ -z "$SSH_CLIENT"  ||  -z "$SSH2_CLIENT" ]]; then 
        eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
    else 
        eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
    fi

    # Get AIX Level into prompt
    PR_BUILD=${PR_BUILD:=`cat /usr/lpp/bos/aix_release.level`}
    #PR_BUILD=${PR_BUILD:=`lslpp -qcL bos.mp 2>/dev/null | cut -d: -f3`}

    # set the prompt
    PS1=$'${PR_CYAN}[${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}][${PR_YELLOW}${PR_BUILD}${PR_CYAN}][${PR_BLUE}%~${PR_CYAN}]${PR_USER_OP} '
    PS2=$'%_>'
}
setprompt


###############################################################################

source ~/.alias
mkdir -p ~/.funcs

awk -v homedir=$HOME '

    BEGIN {comment="# Shell Function"}
    /^#/ && name == "" {
        comment = comment"\n"$0;
        next;
    }

    # Korn Style Function Name
    # A bit of trouble here is many tool embeded in shell have its own function
    # machanism like awk which is heavily used by me. I have to assume that a
    # function with parenthes of parameters are awk functions... which means I
    # have to use parenthes in awk function even no param exist, which seems
    # follows most awk implemention grammar, and no parenthes shall exist in
    # shell function declaration, which means POSIX function will be IGNORED.
    # So, strictly use either POSIX or KSH function in the .func file.
    #/^function/ && !/\(\)/{
    /^function/ && $3 != "(" {
        name = $2;
        fun[name] = comment;    
    }

    # POSIX Style Function Name -- commented out since I choose KSH style now.
    #!/^#/ && /\(\)/ {
    #name = $1;
    #fun[name] = comment;    
    #}
    /; \}$/ && !/next; \}$/ {
        if (name == "") {
        print "Parse Error on Line "NR": "$0;
        next;
        }
        comment = "# Shell Function";
        fun[name] = fun[name]"\n"$0;
        print fun[name] > homedir"/.funcs/"name;
        name = "";
        next;
    }

    NR > 0 {
        fun[name] = fun[name]"\n"$0;
    } 
' ~/.func



FPATH=$FPATH:~/.funcs
autoload ~/.funcs/*(:t)




