#!/bin/bash

read -r libprefix < "$HOME""/.mpdconf"
filename=$(mpc -f "%file%" | head -n 1)
libprefix=${libprefix:25}       # This assumes your ~/.mpdconf stays the same
filestr=${libprefix%$'\"'}$filename
artfile="$HOME""/.ncmpcpp/.artwork.jpg"     # Feel free to change this value
ffmpeg -y -hide_banner -v -8 -i "${filestr}" "$artfile"
if [ $? -eq 1 ]; then
    l1=$(tput lines)
    let l2=$l1/2
    tput clear 
    while [ $l1 -gt 0 ]; do 
        printf "\n"
        let l1=$l1-1
    done
    printf "\t\t┏━━━━━━━━━━━━┓\n"
    printf "\t\t┃ No Artwork!┃\n"
    printf "\t\t┗━━━━━━━━━━━━┛\n"
    while [ $l2 -gt 0 ]; do
        printf "\n"
        let l2=$l2-1
    done
    exit 1
fi
tput clear
sleep 1     # Don't wanna create a race condition
imgcat "$artfile"
tput cup -5,$(tput cols)
