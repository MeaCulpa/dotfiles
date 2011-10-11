#!/bin/sh

ffmpeg -i "$1" -f mp4 -maxrate 720k -bufsize 65536 -vcodec libx264 -flags +loop -cmp +chroma -deblockalpha 0 -deblockbeta 0 -crf 21 -b 720k -refs 1 -coder 0 -me_method full -me_range 16 -subq 5 -partitions +parti4x4+parti8x8+partp8x8 -g 300 -keyint_min 25 -level 30 -trellis 2 -sc_threshold 40 -i_qfactor 0.71 -s 320x240 -aspect 4:3 -acodec libfaac -ab 192kb -ar 48000 -ac 2 $2

