#!/bin/csh
set path = ($path /usr/local/bin)
set w1 = `jot -r 1 2 15`
set filename = `printf "%s " $1:t:r:r`
set grab = `printf "%s " $1:h`
set a = `echo $filename.ts`
set b = `echo "$grab/$filename"_cut.ts`
set c = `echo "$grab/$filename".mp4`
sleep $w1

while (1)
if ( ! -e "$b" ) then
echo "Running Comcut"
comcut --ffmpeg=/usr/bin/ffmpeg --comskip=/usr/bin/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/media/Comskip/comskip.ini "$1" "$b"
echo "Comcut complete"
else
echo "Comcut already done"
endif
break
end

while (1)
if (! `pgrep HandBrakeCLI` ) then
break
endif
echo "HandBrakeCLI is still running. Will try again in a minute."
sleep 60
end

HandBrakeCLI --input "$b" --output "$c" --preset-import-file /media/comchap/hb-dvr.json

rm "$b"
mv "$1" "/media/PlexDVR/.plexignore/$a"
