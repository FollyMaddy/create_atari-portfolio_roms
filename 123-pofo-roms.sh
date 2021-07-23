#!/usr/bin/env bash

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run with sudo. Try 'sudo $0'"
    exit 1
fi

if [[ $(ls) == *.zip* ]];then
  for zip in *.zip;do
    rom=$(basename $zip .zip).rom
    #echo $rom
    cp -f 128kb-fat12.rom $rom
    mount -o loop $rom /mnt/
    unzip $zip -d /mnt/
    touch /mnt/autoexec.bat
    echo "@echo off" > /mnt/autoexec.bat
    echo
    echo "The executable filenames are listed now :"
    ls -w1 /mnt/*.{com,exe,COM,EXE} 2>&-
    #collect executable exe or com files into array
    #https://unix.stackexchange.com/questions/302775/write-ls-to-array-split-by-newline
    collectfiles=()
    readarray collectfiles < <(ls -w1 /mnt/*.{com,exe,COM,EXE} 2>&-)
  if [[ ${#collectfiles[@]} == 1 ]];then
    echo
    echo "One filename detected, presuming we can add this file to the autoexec.bat"
    echo "Adding $(echo $(ls /mnt/*.{com,exe,COM,EXE} 2>&-) | cut -d/ -f3 | cut -d. -f1 | cut -d. -f1)"
    echo "$(echo $(ls /mnt/*.{com,exe,COM,EXE} 2>&-) | cut -d/ -f3 | cut -d. -f1)" >> /mnt/autoexec.bat
  else
    echo 
    echo "What filename do you want to add to the autoexec ?"
    echo "(You can leave the extension)"
    read -p 'filename: ' input
    echo "$input" >> /mnt/autoexec.bat
  fi
  umount /mnt/
  done
fi