mencoder "$1" -vf scale=320:240 -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=720000 -srate 44100 -af resample=44100:0:0 -oac faac -o "$1.mp4"

