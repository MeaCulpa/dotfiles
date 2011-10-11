#!/bin/sh

LOG="/var/log/portage/auto_merge_uD.log"


echo 

DATE=`date +%Y-%m-%d_%Hh%Mm`

#MAILHEADER="To: infernoxu@gmail.com\nFrom: infernoxu@gmail.com\nSubject: Automerge of $DATE: \n"
#echo -e $MAILHEADER > $LOG

echo "To: infernoxu@gmail.com" > $LOG
echo "From: meaculpa@vip.sina.com" >> $LOG
echo "Subject: Automerge of inferno, $DATE: " >> $LOG


echo -e "________________________SYNC PORTAGE TREE________________________\n" >> $LOG

emerge --sync >> $LOG

echo -e "__________________________SYNC OVERLAYS__________________________\n" >> $LOG

layman -S >> $LOG

echo -e "___________________________BUILD LIST____________________________\n" >> $LOG

emerge -uptvDN world >> $LOG

echo -e "________________________FETCHING PACKAGES________________________\n" >> $LOG

emerge -upfDN world | egrep "[ht|f]tp:\/\/" | tr " " "\t" | sed "/^$/d" > world_fetch_url.txt
aria2c -i world_fetch_url.txt -o /usr/portage/distfiles/

echo -e "________________________BUILDING PACKAGES________________________\n" >> $LOG

emerge -uDN world --keep-going >> $LOG

echo -e "________________________PRESERVED REBUILD________________________\n" >> $LOG

emerge @preserved-rebuild --keep-going >> $LOG

echo -e "_________________________REVDEP REBUILD__________________________\n" >> $LOG

revdep-rebuild --keep-going -q >> $LOG

echo -e "___________________________UPDATE EIX____________________________\n" >> $LOG

eix-update >> $LOG

echo -e "____________________________FINISHED_____________________________"

cat "$LOG" | msmtp -t

