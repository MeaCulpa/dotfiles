# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
source /etc/profile
#xhost +local:inferno
#xset m 1.0


#alias
alias measyncall="emerge --sync && layman -S && update-eix && emerge -uptDN world"
alias measync="emerge --sync && layman -s akoya && layman -s gentoo-china && layman -s sabayon && update-eix && emerge -uptDN world"
alias meausys="emerge -uDN system || until emerge --resume --skipfirst; do emerge --resume --skipfirst; done"
alias meauworld="emerge -uDN world || until emerge --resume --skipfirst; do emerge --resume --skipfirst; done"
alias ll="ls -l"
alias la="ls -a"
alias pa="ps -A"
alias pag="ps -A |grep"
alias meavel="tail -f /var/log/emerge.log"
#mails
alias muttimap="mutt -F .muttrc_imap"
alias fetchmailakv="fetchmail -akv"

#coloerd man page
export PAGER=most

alias slrn_cn99="export NNTPSERVER=news.cn99.com && slrn"
alias slrn_newsfan="export NNTPSERVER=news.newsfan.net && slrn"
alias slrn_ms="export NNTPSERVER=msnews.microsoft.com && slrn"
alias slrn_hk="export NNTPSERVER=news.newsgroup.com.hk && slrn"
alias slrn_netfront="export NNTPSERVER=freenews.netfront.net && slrn -C"
alias slrn_webking="export NNTPSERVER=news.webking.cn && slrn -C"
alias slrn_gmane="export NNTPSERVER=news.gmane.org && slrn -C"
alias slrn_camb="export NNTPSERVER=textnews.news.cambrium.nl && slrn -C"
alias slrn_ru="export NNTPSERVER=news.mi.ras.ru && slrn -C"

alias viewpic="feh -F -Z"
alias nautilus="nautilus --no-desktop"
alias dropbox="python ~/scripts/dropbox.py"

alias btwit="bti --proxy 127.0.0.1:8118 --host twitter --account methuselar --password XXXXXX"
alias bident="bti --host identica --account meaculpa --password XXXXXX"
alias ttytwt="proxychains ~/scripts/ttytter.pl -user=methuselar:XXXXXX -hold"

export FLICKR_UPLOADR_PY_API_KEY=df782291f03a9f38a9fce4e708429d90
export FLICKR_UPLOADR_PY_SECRET=f963e699f2829000

export PATH=$PATH:~/scripts

export BZR_EDITOR=vim

#python ~/scripts/dropbox.py start


