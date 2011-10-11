mencoder "$1" -o $1.mp4 -vf scale=480:320,harddup -of lavf -lavfopts format=ipod -alang en -sws 2 -oac faac -faacopts br=128:mpeg=4:object=2:raw -srate 44100 -ovc x264 -x264encopts bitrate=800:nocabac:level_idc=30:bframes=0:global_header:threads=2:subq=5:frameref=6:partitions=all:trellis=1:chroma_me:me=umh

