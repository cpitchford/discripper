#!/bin/bash

# No commas or \ 
# This is used in a s// in sed, so be careful

PREFIX=/opt/bluray




case "$1" in
  prepare-env)
    echo "Adding handbrake repository"
    add-apt-repository ppa:stebbins/handbrake-releases
    echo "Installing essential packages"
    apt-get install -y build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev handbrake-cli
    echo ""
    echo ""
    echo "Now download the latest MakeMKV tools from"
    echo "   http://www.makemkv.com/forum2/viewtopic.php?f=3&t=224"
    echo ""
    echo "Put the tar files in the src/ folder"
    exit $?
  ;;
  [0-9][0-9.]*)
    if [[ ! $1 =~ ^[0-9][0-9.]+$ ]] ; then
      echo "Invalid makemkv version"
      exit 127
    fi
    for i in src/makemkv-{bin,oss}-"$1".tar.gz ; do
      if ! [[ -r $i && -f $i ]] ; then
        echo "Cannot find $i"
        exit 1
      fi
    done

    set -e

    rm -rf build
    mkdir build
    tar xvfC src/makemkv-bin-"$1".tar.gz build
    tar xvfC src/makemkv-oss-"$1".tar.gz build

    cd build/makemkv-oss-"$1"
    ./configure --prefix="$PREFIX"
    make
    make install
    cd ../..
    cd build/makemkv-bin-"$1"
    sed -i 's,/usr,'"$PREFIX"',g' Makefile
    mkdir tmp
#    echo > tmp/eula_accepted
    make install
    cd ../..
    sed "s,^PREFIX=.*,PREFIX=$PREFIX," src/rip > "$PREFIX/bin/rip"
    chmod 755 "$PREFIX/bin/rip"
    echo "Install completed, run $PREFIX/bin/rip"
  ;;
  *)
     echo "$0 prepare-env"
     echo "$0 makekv-version"
  ;;
esac

    