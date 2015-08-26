# DiscRipper
Really basic BluRay/DVD ripping script, using [HandBrake](https://handbrake.fr) and [MakeMKV](http://www.makemkv.com/) CLI tools to rip disc and disc images to MKV files.

#### Requirements
It is written for use on Ubuntu 14.04. The rip script itself is fairly generic, but the installs script calls apt and ubuntu ppa.
You must download the MakeMKV Linux source/binaries from [MakeMKV](http://www.makemkv.com/)

#### Installation
1. Download the MakeMKV tar files and place them in the src folder
1. Edit the src/rip file to set the device (/dev/sr0) and any SFTP upload location
1. Edit the install.sh to change the install prefix
1. run sudo ./install.sh prepare-env
1. run sudo ./install.sh 1.9.x (use the version of MakeMKV)

#### Use
Try running /opt/bluray/bin/rip

The script should attempt to automatically rip either a DVD or BluRay disk, automatically selecting the correct stream (first, large track) and using the disc title as the filename

#### Notes
This was never intended to be public, it was thrown together in an evening when I couldn't get a BluRay I'd bought to play back using UltraVoliet on a Roku (still doesn't work). Bug me on reddit if you have suggestions or questions. I hope it helps.
