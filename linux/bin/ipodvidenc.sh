## ipodvidenc - The iPod Video Encoder for Linux.
## Created by Eric Hewitt, January 9, 2006.
## Released under the GPL.  Go nuts.

input_file=$1

echo "What would you like to name the output file (sans extension)?"

read output_file_name

echo "$output_file_name will be located in $PWD. Is this acceptable? [y/n]"

read output_file_loc_permis

if [ $output_file_loc_permis = 'n' ] || [ $output_file_loc_permis = 'N' ]
then
        echo "Where would you like to store $output_file_name.mov?"
        read output_dir
else
        output_dir=$PWD
fi

ffmpeg -i ${input_file} -f mp4 -vcodec mpeg4 -maxrate 1000k -b 700k -qmin 3 -qmax 5 -bufsize 4096k -g 300 -acodec aac -ab 192k -s 320x240 -aspect 4:3 ${output_dir}/${output_file_name}.mov