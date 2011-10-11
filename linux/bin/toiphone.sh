#ffmpeg -i "$1" -f mp4 -vcodec libx264 -maxrate 768k -b 768k  -s 480x320 -aspect 3:2 -qmin 3 -qmax 5 -g 300 -acodec libfaac -ab 128k -threads 1 -y $1.mp4
#ffmpeg -i "$1" -f mp4 -acodec libfaac -ab 128k -s 480x320 -vcodec libx264 -b 768k -aspect 3:2 -threads 0 -y $1.mp4

#ffmpeg -i "$1" -acodec libfaac -ab 128k -vcodec libx264 -vpre hq -crf 22 -threads 0 $1.mp4

############################
# Original:
# First Pass
#ffmpeg -i INPUT -an -pass 1 -vcodec libx264 -b BIT_RATE -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method dia -subq 1 -trellis 0 -refs 1 -bf 16 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt BIT_RATE -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 OUTPUT.mp4
# Second Pass
#ffmpeg -i INPUT -acodec libfaac -ab 128k -pass 2 -vcodec libx264 -b BIT_RATE -flags +loop -cmp +chroma -partitions +parti8x8+parti4x4+partp8x8+partp4x4+partb8x8 -flags2 +dct8x8+wpred+bpyramid+mixed_refs -me_method umh -subq 7 -trellis 1 -refs 6 -bf 16 -directpred 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt BIT_RATE -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 OUTPUT.mp4
############################

#1 pass
# new using presets (http://rob.opendot.cl/index.php/useful-stuff/ipod-video-guide/)
ffmpeg -i "$1" -acodec libfaac -ac 2 -ab 128k -s 480x320 -vcodec libx264 -vpre libx264-hq -vpre libx264-ipod640 -b 768k -bt 512k -aspect 3:2 -threads 0 -f mp4 $1.mp4



# old method (http://rob.opendot.cl/index.php/useful-stuff/ffmpeg-x264-the-old-way-encoding-guide/)
# ffmpeg -i "$1" -acodec libfaac -ab 192k -ar 48000 -vcodec libx264 -b 768k -s 480x320 -aspect 3:2 -r 26 -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method dia -subq 1 -trellis 0 -refs 1 -bf 16 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 -f mp4 -y $1_iphone.mp4



# ffmpeg -i "$1" -acodec libfaac -ab 192k -ar 48000 -vcodec libx264 -b 500k -s 480x320 -aspect 3:2 -r 26 -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method dia -subq 1 -trellis 0 -refs 1 -bf 16 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 -f mp4 -y $1_iphone.mp4

# 2 pass
#ffmpeg -i "$1" -acodec libfaac -ab 128k -an -pass 1 -vcodec libx264 -b 768k -s 480x320 -aspect 3:2 -r 26 -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method dia -subq 1 -trellis 0 -refs 1 -bf 16 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 -f mp4 -y $1.mp4
#ffmpeg -i "$1" -acodec libfaac -ab 128k -pass 2 -vcodec libx264 -b 768k -s 480x320 -aspect 3:2 -r 26 -flags +loop -cmp +chroma -partitions +parti8x8+parti4x4+partp8x8+partp4x4+partb8x8 -flags2 +dct8x8+wpred+bpyramid+mixed_refs -me_method umh -subq 7 -trellis 1 -refs 6 -bf 16 -directpred 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0 -f mp4 -y $1.mp4

#ffmpeg -i "$1" -an -pass 1 -vcodec libx264 -b 768k -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me_method dia -subq 1 -trellis 0 -refs 1 -bf 16 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0   -f mp4 -y $1.mp4
#ffmpeg -i "$1" -acodec libfaac -ab 128k -pass 2 -vcodec libx264 -b 768k -flags +loop -cmp +chroma -partitions +parti8x8+parti4x4+partp8x8+partp4x4+partb8x8 -flags2 +dct8x8+wpred+bpyramid+mixed_refs -me_method umh -subq 7 -trellis 1 -refs 6 -bf 16 -directpred 3 -b_strategy 1 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 500k -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -threads 0  $1.mp4

#mencoder "$1" -o $1.mp4 -vf scale=480:320,harddup -of lavf -lavfopts format=ipod -alang en -sws 2 -oac faac -faacopts br=128:mpeg=4:object=2:raw -srate 44100 -ovc x264 -x264encopts bitrate=800:nocabac:level_idc=30:bframes=0:global_header:threads=2:subq=5:frameref=6:partitions=all:trellis=1:chroma_me:me=umh
