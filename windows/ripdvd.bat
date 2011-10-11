rem -identify -frames 0 -vc null -vo null -ao null 查看信息
mencoder -dvd-device I:\ dvd://1 -sid 1 -o H:\1.avi -oac copy -ovc lavc -lavcopts vcodec=mpeg4 -quiet
