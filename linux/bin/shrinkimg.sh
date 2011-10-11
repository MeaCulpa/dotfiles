mkdir converted
find . -name '*.JPG' | while read i;do convert -resize 33% "$i" "./converted/${i%}";done
