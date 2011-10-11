#!/bin/bash
# Name:    podit
# Summary: iPod H264 640x480 video transcoder script. 
# Version: 1.1.2
# Date:    2008.10.23
# License: GPL Version 3 or Later
# URL:     http://slated.org/howto_transcode_h264_for_ipod_with_ffmpeg
# © [H]omer, 2007 - 2008
#
# Requires: ffmpeg
# Requires: gpac
# Requires: perl-DateManip
#

# These requirements are a guide only. As a minimum you'll
# need ffmpeg and MP4Box (from gpac). You could even get away
# without using MP4Box, although I doubt you will have iTunes
# compatible files (they'll still work with the iPod though).
# Any components you don't want to use (MP4Box, Perl-DateManip)
# will need to be edited/commented out of this script first.

#########################################################################
# This program is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation, either version 3 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program.  If not, see <http://www.gnu.org/licenses/>. #
#########################################################################

###########################################################
# Credits...                                              #
# Forums:        Doom9, Videohelp, and Ubuntu.            #
# Mailing lists: MPlayer and ffmpeg.                      #
# Blogs:         Everywhere.                              #
#                                                         #
# Special thanks to jdong on Ubuntu forums.               #
#                                                         #
# Note 1: This script is *very* CPU intensive (slow),     #
#         and will probably melt your PC, but then again  #
#         it *does* produce incredibly high quality video #
#         so IMHO it's worth it. YMMV.                    #
#                                                         #
# Note 2: Now uses MP4Box to "fix" the files for iTunes.  #
#                                                         #
# Note 3: This script references an external Perl script  #
#         called deltadays.pl. Please edit the location   #
#         of this file (below). If that script was not    #
#         included with this one, then it should have     #
#         been. Fetch a copy from my website, or simply   #
#         remove the call to the "transtime" function,    #
#         (which you can then also remove if you like) at #
#         the end of this script.                         #
#                                                         #
# Note 4: I've changed podit to work on a *copy* of the   #
#         original file, rather than directly on the      #
#         source, primarily because I was transcoding     #
#         over a network, and it just made more sense to  #
#         work on local copies.                           #
#                                                         #
###########################################################

################################
### User definable variables ###
###########################################################
# These are the only 4 prefs I would recommend you alter. #
###########################################################
#                                                         #
# framerate: e.g. (10, 15, 23.976, 25, 29.97, 30 = MAX)   #
# A value of 0 will make the output file the same frame   #
# -rate as the input file.                                #
#                                                         #
# framelimit: transcode only the first [n] frames.        #
# (Good for testing.) A value of 0 disables this limit.   #
#                                                         #
# resolution: 320x240 / 640x480 (4:3 aspect)              #
#             320x176 / 640x352 (16:9 aspect)             #
# Other resolutions are possible (untested).              #
#                                                         #
# passes: 1 or 2 pass encoding. ffmpeg does not support   #
# >2 passes, not that >2 passes is very useful anyway.    #
#                                                         #
# NOTE: THIS SCRIPT CURRENTLY DOES *NO* ERROR CHECKING,   #
#       SO PLEASE USE SENSIBLE VALUES.                    #
#                                                         #
###########################################################

framerate=25
framelimit=0
resolution="640x480"
passes=2
croptop_val=0
cropbottom_val=0
cropleft_val=0
cropright_val=0
video_bitrate="600k"
audio_bitrate="160"

########################
### Static variables ###
########################
infile="$1"

####################################
### Location of deltadays script ###
### Requires: Perl::Date-Manip   ###
### ... and the script itself :) ###
############### EDIT ME ############
deltadays="deltadays.pl"
tmpdir="${HOME}/tmp"
mkdir -p "${tmpdir}"

############################
### transcoding function ###
############################
podenc () {
   local passval=$1
   if [ $passval -eq 0 ]
      then
         local passvar=""
      else
         local passvar="-pass $passval"
   fi
   if [ $framelimit -eq 0 ]
      then
         local framesvar=""
      else
         local framesvar="-vframes $framelimit"
   fi
   if [ $framerate -eq 0 ]
      then
         local ratevar=""
      else
         local ratevar="-r $framerate"
   fi
   ### You are not expected to understand this. I know *I* don't.
   nice -n 19 ffmpeg -y $ratevar -i "${tmpfile1}" $ratevar $framesvar \
        -cropleft $cropleft_val -cropright $cropright_val \
        -croptop $croptop_val -cropbottom $cropbottom_val \
        -v 1 -vcodec libx264 -b ${video_bitrate} -bt 175k -refs 2 -loop 1 \
        -deblockalpha 0 -deblockbeta 0 -parti4x4 1 -partp8x8 1 \
        -partb8x8 1 -me full -subq 6 -brdo 1 -me_range 21 -chroma 1 \
        -slice 2 -bf 0 -level 13 -g 300 -keyint_min 30 \
        -sc_threshold 40 -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.7 \
        -qmax 35 -qdiff 4 -i_qfactor 0.71428572 -b_qfactor 0.76923078 \
        -maxrate 768k -bufsize 3000k -cmp 1 -s $resolution -acodec libfaac \
        -ab ${audio_bitrate} -ar 48000 -ac 2 -f mp4 $passvar "${tmpfile2}"
   exit_status=$?
}

########################################
###### Calculate transcoding time ######
########################################
transtime () {
   local newdate=$1
   local olddate=$2

   local difftime=$(perl "$deltadays" "$newdate" "$olddate" | sed -e s/^.//)

   local diffyears=$(echo $difftime | cut -d':' -f1)
   local diffmonths=$(echo $difftime | cut -d':' -f2)
   local diffweeks=$(echo $difftime | cut -d':' -f3)
   local diffdays=$(echo $difftime | cut -d':' -f4)
   local diffhours=$(echo $difftime | cut -d':' -f5)
   local diffminutes=$(echo $difftime | cut -d':' -f6)
   local diffseconds=$(echo $difftime | cut -d':' -f7)

   echo -ne "\033[1;31mTranscoding time: "

   if [ "$diffyears" -ne 0 ]
      then
         echo -n "$diffyears Years, "
   fi

   if [ "$diffmonths" -ne 0 ]
      then
         echo -n "$diffmonths Months, "
   fi

   if [ "$diffweeks" -ne 0 ]
      then
         echo -n "$diffweeks Weeks, "
   fi

   if [ "$diffdays" -ne 0 ]
      then
         echo -n "$diffdays Days, "
   fi

   if [ "$diffhours" -ne 0 ]
      then
         echo -n "$diffhours Hours, "
   fi

   if [ "$diffminutes" -ne 0 ]
      then
         echo -n "$diffminutes Minutes, "
   fi

   echo -e "$diffseconds seconds.\033[0m"
} 

##############################
###### Reverse a string ######
##############################
reverseit () {
local instring=$1
instring_length=$(echo -n "${instring}" | wc -c)
reverse_string=
while [ ${instring_length} -gt 0 ]
   do
      reverse_string=${reverse_string}$(echo ${instring} | cut -c ${instring_length})
      let instring_length=instring_length-1
   done
echo "${reverse_string}"
}

##################################
###### Strip file extension ######
##################################
stripext () {
local instring=$1
local revnoext_string=$(reverseit "${instring}" | sed 's/^.*\.//')
reverseit "${revnoext_string}"
}

##################
###### Main ######
##################
outdir=$(find "${infile}" -printf "%h")
base_name=$(basename "${infile}")
barename=$(stripext "${base_name}")
outfile="${outdir}/${barename}.podit.mp4"
tmpfile1="${tmpdir}/${base_name}"
tmpfile2="${tmpdir}/${barename}.podit.mp4"
tmpfile3="${tmpdir}/${barename}.podit.m4v"

clear

if [ -e "${outfile}" ]
   then
      echo -n "\"${outfile}\" already exists. Overwrite? (y/n): "
      read answer
      if [ "$answer" != "y" ]
         then
            echo "Transcoding aborted on user request."
            sleep 3
            exit 1
      else
         echo
      fi
fi

count=1
while [ $count -lt 11 ]
   do
      let countdown=11-$count
      let count=count+1
      echo -n "Transcode will proceed in $countdown seconds."
      sleep 1
      echo -ne "\b \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
   done
echo -ne "                                       \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"

rm -f "${tmpfile1}" "${tmpfile2}" "${tmpfile3}" "${outfile}"
echo "Copying \"${base_name}\" to \"${tmpdir}\""
cp -a "${infile}" "${tmpfile1}"

starttime=$(date +%Y%m%d%H:%M:%S)

echo
if [ "$passes" -eq 1 ]
   then
      podenc 0
   else
      podenc 1
      podenc 2
fi

if [ "$exit_status" -ne 0 ]
   then
      echo "Something went wrong with ffmpeg."
      echo "Please check the output and try again."
      exit 1
fi

endtime=$(date +%Y%m%d%H:%M:%S)
echo
transtime $starttime $endtime
echo

echo "Removing temporary copy of source file."
rm -f "${tmpfile1}"

echo
echo "Fixing transcoded file for iPod with MP4Box."
echo
MP4Box -ipod -add "${tmpfile2}" "${tmpfile3}"

if [ "$?" -ne 0 ]
   then
      echo "Something went wrong with MP4Box."
      echo "Please check the output and try again."
      exit 1
fi

echo
echo "Removing MP4Box's temporary source file."
rm -f "${tmpfile2}"

echo
echo "Moving finished video to ${outdir}"
mv "${tmpfile3}" "${outfile}"

echo
echo -e "\033[1;31mJob \"${barename}\" completed successfully.\033[0m"
sleep 10

exit 0