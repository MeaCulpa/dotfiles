
ffmpeg -i "$1" -s qcif -vcodec h263 -acodec libfaac -ac 1 -ar 44100 -r 25 -ab 32 -y "$2"

