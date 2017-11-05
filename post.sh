#!/bin/csh
sleep 5
set filename = `printf "%s " $1:t:r:r`
set grab = `printf "%s " $1:h`
set a = `echo $filename.ts`
set b = `echo "$grab/$filename"--cut.ts`
set c = `echo "$grab/$filename".mp4`
comcut --ffmpeg=/usr/bin/ffmpeg --comskip=/usr/bin/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/media/Comskip/comskip.ini "$1" "$b"
HandBrakeCLI --input "$b" --output "$c"  --preset-import-file /media/comchap/hb-dvr.json
mv "$1" /media/dvrarchive/"$a"
rm "$b"
exit
