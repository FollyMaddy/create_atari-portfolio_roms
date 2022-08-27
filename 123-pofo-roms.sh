#!/usr/bin/env bash

#
# Author : @folly
# Date   : 01/08/2021
#
# Copyright 2021 @folly
#
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


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
    echo "You can apply multiple commands if you need to."
    echo "This can be done by separating the commands with \\\n."
    echo "For example : cd <subdirectory>\\\n<program>."
    echo "You can leave the extension, if you want."
    echo "Please enter your command(s) and/or program name :"
    read -p '' input
    echo -e "$input" >> /mnt/autoexec.bat
  fi
  umount /mnt/
  chown $(ls /home):$(ls /home) $(basename $zip .zip).rom
  done
fi
