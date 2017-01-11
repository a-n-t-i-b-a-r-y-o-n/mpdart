#!/bin/bash

read -r libprefix < "$HOME""/.mpdconf"
filename=$(mpc -f "%file%" | head -n 1)
libprefix=${libprefix:25}       # This assumes your ~/.mpdconf stays the same
filestr=${libprefix%$'\"'}$filename
artfile="$HOME""/.ncmpcpp/.artwork.jpg"
ffmpeg -y -hide_banner -i "${filestr}" "$artfile"
ec=$?
if [ $ec -eq 0 ]; then 
    imgcat "$artfile"
    exit $ec
fi
l1=$(tput lines)
let l2=$l1/2
if [ $ec -eq 1 ]; then 
    while [ $l1 -gt 0 ]; do 
        printf "\n"
        let l1=$l1-1
    done
    printf "\t\tNo Artwork!"
    while [ $l2 -gt 0 ]; do
        printf "\n"
        let l2=$l2-1
    done
    exit $ec
fi
