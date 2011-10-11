#!/bin/sh
# fetch portage packages using aria2c
#usage: worldfetch
emerge -upfDN world | egrep "[ht|f]tp:\/\/" | tr " " "\t" | sed "/^$/d" > world_fetch_url.txt
aria2c -i world_fetch_url.txt -o /usr/portage/distfiles/

