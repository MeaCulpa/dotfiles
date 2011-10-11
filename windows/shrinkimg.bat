ls -1 *.jpg | sed "s/\(.*\)\.JPG/E:\\imagemagick\\convert.exe -resize 50%%%% & \1_.jpg/g" > shrink.bat
