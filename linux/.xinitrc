#export XMODIFIERS="@im=SCIM"
#export XIM="scim-bridge"
#export XIM_PROGRAM="scim-bridge"
#export XIM_ARGS="-d"
export GTK_IM_MODULE="scim-bridge"
export QT_IM_MODULE="scim-bridge"

export XMODIFIERS="@im=SCIM"
export XIM="scim"
export XIM_PROGRAM="scim"
export XIM_ARGS="-d"
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"

#export XMODIFIERS="@im=fcitx"
#export XIM="fcitx"
#export XIM_PROGRAM="fcitx"
#export XIM_ARGS="-d"
#export GTK_IM_MODULE="fcitx"
#export QT_IM_MODULE="fcitx"

#export XMODIFIERS="@im=IBUS"
#export XIM="ibus"
#export XIM_PROGRAM="ibus"
#export XIM_ARGS="-d"
#export GTK_IM_MODULE="ibus"
#export QT_IM_MODULE="ibus"


export OOO_FORCE_DESKTOP=gnome
#exec /usr/bin/ssh-agent -- /usr/bin/gnome-session
#exec /usr/bin/ssh-agent -- /usr/kde/3.5/bin/startkde
xset m 1 0
xset -b
xmodmap /home/inferno/.Xmodmap
scim -d
#fcitx -d
#ibus-daemon &
#conky
pypanel &
urxvtd -q -f
#/usr/kde/4.2/bin/startkde
#/usr/kde/3.5/bin/startkde


#exec fluxbox
#exec xmonad
#awesome
exec echinus

#startxfce4
#exec icewm
#fvwm&
#startkde

#DEFAULT_SESSION=fluxbox

#case $1 in
#kde)
#	exec startkde
#	;;
#awesome)
#	exec awesome
#	;;
#fluxbox)
#	exec fluxbox
#	;;
#*)
#	exec $DEFAULT_SESSION
#	;;
#esac
#fbsetbg -c -r ~/pic/wallpaper
#awsetbg -c -r ~/pic/wallpaper

#dropbox start

setxkbmap en_US

#drop box daemon
#dropbox start


