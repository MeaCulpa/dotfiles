# From Cygwin To USB
#rsync -avz --exclude-from=/cygdrive/d/bkskyrim/dump/exclude.txt --delete --stats /cygdrive/d/Skyrim/Data /cygdrive/h/skyrim/dump
#rsync -nrtz --progress --exclude-from=/cygdrive/d/bkskyrim/dump/exclude.txt --delete --stats /cygdrive/d/Skyrim/Data /cygdrive/h/skyrim/dump
#rsync -nrtz --progress --exclude-from=/cygdrive/d/bkskyrim/dump/exclude.txt --delete --stats /cygdrive/d/Skyrim/Data /cygdrive/h/skyrim/dump
# From Cygsin To Linux
rsync -nrtz --progress --exclude-from=/cygdrive/d/bkskyrim/dump/exclude.txt --delete --stats /cygdrive/d/Skyrim/Data inferno@192.168.11.3:/data/w1/Skyrim

# From USB To Linux
rsync -nrtz --exclude-from=/mnt/usb/skyrim/dump/exclude.txt --delete --progress --stats /mnt/usb/skyrim/dump/Data /data/w1/Skyrim

