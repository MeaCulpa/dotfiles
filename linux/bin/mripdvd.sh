#mplayer -identify /dev/sr0 -nosound -vc dummy -vo null
#-sid ��������ָ����Ļid
for (( c=$1; c<=$2; c++ ))
do
    mencoder -dvd-device /dev/sr0 dvd://$c -o $c.avi -oac copy -ovc lavc -lavcopts vcodec=mpeg4 -quiet
done

