###############################################################################
#!/bin/zsh
# vim:fdm=marker
# .zshrc, jyxu

source /etc/profile

###############################################################################
# Variables
# ENV
export HISTFILE=~/.sh_history
export HISTSIZE=10000
export SAVEHIST=10000 
export PATH=$PATH:~/bin
export PAGER=less
export EDITOR=vim

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
    # set the prompt
    PS1=$'${PR_CYAN}[${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}][${PR_BLUE}%~${PR_CYAN}]${PR_USER_OP}'
    PS2=$'%_>'
}
setprompt


###############################################################################
# Window title
#case $TERM in
    #*xterm*|rxvt|rxvt-unicode|rxvt-256color|(dt|k|E)term)
        #precmd () { print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" } 
        #preexec () { print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" }
    #;;
    #screen|*xterm*)
        #precmd () { 
            #print -Pn "\e]83;title \"$1\"\a" 
            #print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
        #}
        #preexec () { 
            #print -Pn "\e]83;title \"$1\"\a" 
            #print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
        #}
    #;; 
#esac

precmd () {
    local tmp='%~'
    local HPWD=${(%)tmp}
    if [[ $TERM = screen ]]; then
        printf '\ek%s\e\\' $HPWD
    fi
}

###############################################################################
# Gentoo Specific
export BZR_EDITOR=vim
export PAGER=most
export PATH=$PATH:~/bin

# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $TERM == "screen" ]]; then
  _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"'

  # use the current user as the prefix of the current tab title (since that's
  # fairly important, and I change it fairly often)
  TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR"'
  # when at the shell prompt, show a truncated version of the current path (with
  # standard ~ replacement) as the rest of the title.
  TAB_TITLE_PROMPT='$SHELL:t'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'

  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'

  # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set()
  {
    # set the tab window title (%t) for screen
    print -nR $'\033k'$1$'\033'\\\

    # set hardstatus of tab window (%h) for screen
    print -nR $'\033]0;'$2$'\a'
  }
  # called by zsh before executing a command
  function preexec()
  {
    local -a cmd; cmd=(${(z)1}) # the command string
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    screen_set $tab_title $tab_hardstatus
  }
  # called by zsh before showing the prompt
  function precmd()
  {
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
    screen_set $tab_title $tab_hardstatus
  }
fi

source ~/.alias
source ~/.zshalias

mkdir -p ~/.funcs

# split .func file into small functions under .funcs for autoloading
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


# try out sth
#precmd() {
       #echo
   #}


