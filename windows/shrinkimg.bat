ls -1 *.jpg | awk " {system(\"D:\\imagemagick\\convert.exe -resize 50%% \"$1\" s_\"$1)} "
