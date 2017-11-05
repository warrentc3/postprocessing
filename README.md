## Automatic commercial removal and mp4 encoding on FreeNAS 11
##
inspired by... https://emby.media/community/index.php?/topic/49900-automated-commercial-removal-from-tv-recordings/
##
install packages
##
pkg update;
pkg install nano;
pkg install autoconf;
pkg install automake;
pkg install libtool;
pkg install argtable;
pkg install handbrake;
pkg install ffmpeg;
pkg install bash;
pkg install gcc6;
pkg install git;
pkg set -o devel/pkg-config:devel/pgkconf
pkg install -f devel/pkgconf
## 
set symlinks for nano and ffmpeg
##
ln -s /usr/local/bin/nano /usr/bin/nano
ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
## 
set env variables for nano and gcc
##
cd  /
nano .cshrc 
##
Then change/add these lines 
##
sentev	CC	gcc6
setenv  EDITOR  nano
## 
pull Comskip/comchap from git
##
mkdir /usr/local/comchap
mkdir /usr/local/Comskip
cd /usr/local 
git clone --depth 1 git://github.com/erikkaashoek/Comskip
cd /usr/local/Comskip
./autogen.sh
./configure
make
cd /usr/local 
git clone --depth 1 git://github.com/BrettSheleski/comchap
## 
set symlinks for Comskip/comchap
##
ln -s /usr/local/Comskip/comskip /usr/bin/comskip
ln -s /usr/local/comchap/comcut /usr/bin/comcut
ln -s /usr/local/comchap/comchap /usr/bin/comchap

## use post.sh to process recordings
