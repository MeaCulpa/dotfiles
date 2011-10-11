
ffmpeg -i "$1" -acodec libfaac -ab 192k -ar 48000 -vcodec libx264 -b 768k -s 480x320 -aspect 3:2 -r 26 -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method dia -subq 1 -trellis 0 -refs 1 -bf 16 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 -f mp4 -y $2.mp4
