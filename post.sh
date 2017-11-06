#!/bin/csh
set w1 = `jot -r 1 4 20`
set w2 = `jot -r 1 5 30`
set w3 = `jot -r 1 5 30`
sleep $w1
set filename = `printf "%s " $1:t:r:r`
set grab = `printf "%s " $1:h`
set a = `echo $filename.ts`
set b = `echo "$grab/$filename"--cut.ts`
set c = `echo "$grab/$filename".mp4`
cp "$1" /media/PlexDVR/.plexignore/"$a"
while (1)
        if (-e "/tmp/comchap.lock") then
                sleep $w2
        else if (`pgrep HandBrakeCLI`) then
                sleep $w3
        else
                comcut --ffmpeg=/usr/bin/ffmpeg --comskip=/usr/bin/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/media/Comskip/comskip.ini "$1" "$b"
                HandBrakeCLI --input "$b" --output "$c"  --preset-import-file /media/comchap/hb-dvr.json
                rm "$b"
                break
        endif
end
exit
