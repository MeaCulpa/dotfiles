# inputfile bitrate framerate resolution audiofreq audiobitrate ptop
# pbottom pleft pright tmpfile logfile ffmpegpath

# SUBQ - time vs. quality
# 7=highest quality, 35% slower
# 6=high quality
# 5=normal quality - don't use in 2 pass
# ME - motion estimation
# hex=normal quality - don't use in 2 pass
# umh=high quality, 40% slower
# QCOMP
# 0=stills good, motion bad (constant bitrate)
# 1=motion good, stills ok (constant quality)
# 0.6=default
# 0.7-0.8=most people's taste
# KEYINT - keyframes interval (frames, 250 for 25 fps = 10 sec)
# REFS - reference frames
# TRELLIS - Trellis RD Quantization
# 0=disabled
# 1=a bit higher quality, slower
# 2=max quality, very slow

inputfile=$1
bitrate=$2
framerate=$3
resolution=$4
audiohz=$5
audiobitrate=$6
padtop=$7
padbottom=$8
padleft=$9
shift
padright=$9
shift
tmpfile=$9
shift
logfile=$9
shift
fpath=$9

threads=2
subq=6
keyint=$(bc -l <<< $framerate' * 10')
keyint=`echo "tmp=$keyint; tmp /= 1; tmp" | bc`
keyintmin=`echo "tmp=$framerate; tmp /= 1; tmp" | bc`

alloptions="-vcodec libx264 -b "$bitrate"000 -r "$framerate" -s
"$resolution" -bf 3 -qcomp 0.7 -g "$keyint" -keyint_min "$keyintmin"
-refs 5 -loop 1 -flags +4mv -cmp 256 -coder 0 -me_range 16
-sc_threshold 40 -i_qfactor 0.71 -level 30 -qmin 10 -qmax 51 -qdiff 4
-padcolor 000000 -padtop "$padtop" -padbottom "$padbottom" -padleft
"$padleft" -padright "$padright

firstoptions="-subq 1 -me hex -partitions 0 -trellis 0 -flags2
+mixed_refs"

secondoptions="-subq "$subq" -me umh -partitions
parti4x4+parti8x8+partp4x4+partp8x8+partb8x8 -flags2
+wpred+mixed_refs+brdo+8x8dct -trellis 1"

thecommand=$fpath"ffmpeg -y -i "$inputfile" -threads "$threads" -pass
1 -an $alloptions $firstoptions -passlogfile "$logfile" "$tmpfile

echo $thecommand
echo
$thecommand
echo

thecommand="rm "$tmpfile

echo $thecommand
echo
$thecommand
echo

thecommand=$fpath"ffmpeg -y -i "$inputfile" -threads "$threads" -pass
2 -acodec libfaac -ar "$audiohz" -ab "$audiobitrate"000 -ac 2
$alloptions $secondoptions -passlogfile "$logfile" "$tmpfile

echo $thecommand
echo
$thecommand
echo

