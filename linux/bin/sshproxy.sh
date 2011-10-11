#!/bin/sh
ssh -qTfnN methuselar@gasewu.com -D 7070
#ssh -qTfnN -o ServerAliveInterval=60 -c blowfish-cbc -D 7070 methuselar@gasewu.com

# ssh -qTfnN ucarenya@ucarenya.com -D 7070
# while true
# do
#    ssh -TN methuselar@gasewu.com -D 7070
# done

# ssh -o ServerAliveInterval=60 methuselar@gasewu.com -Cg  -D 7070
