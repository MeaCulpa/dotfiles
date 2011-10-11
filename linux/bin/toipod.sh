#!/bin/sh
ffmpeg -i "$1" -f mp4 -vcodec libxvid -maxrate 720k -b 400k -qmin 3 -qmax 5 -bufsize 4096 -g 300 -acodec libfaac -ac 2 -ar 48000 -ab 192k -s 320x240 -aspect 4:3 $1_ipod.mp4
#ffmpeg -i "$1" -f mp4 -vcodec libxvid -me_method epzs -me_range 16 -mbd 1 -qns 0 -g 250  -bf 0 -b 768K -r 24 -aspect 3:2 -s 320x240 -acodec libfaac -ab 128000 -threads 1  -y $1.mp4
#find . -name '*.mkv' | while read i;do ffmpeg "$i" -f mp4 -vcodec libxvid -maxrate 360k -b 360k -qmin 3 -qmax 5 -bufsize 4096 -g 300 -acodec libfaac -ar 44100 -ab 192k -s 320x240 -aspect 4:3 $i.mp4;done

