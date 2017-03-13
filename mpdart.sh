#!/bin/bash

read -r libprefix < "$HOME""/.mpdconf"
filename=$(mpc -f "%file%" | head -n 1)
libprefix=${libprefix:25}       # This assumes your ~/.mpdconf stays the same
filestr=${libprefix%$'\"'}$filename
artfile="$HOME""/.ncmpcpp/.artwork.jpg"     # Feel free to change this value
ffmpeg -y -hide_banner -v -8 -i "${filestr}" "$artfile"
if [ $? -eq 1 ]; then
    l1=$(tput lines)
    let l2=("$l1"/2)-1
    tput clear 
    coloffset=$(tput cols)/2
    let coloffset=$coloffset-7  # The message box is 14 cols wide, so...
    printf "%0.s\n" $(seq 1 "$l1")  #Kinda hacky but it works
    if [ $coloffset -gt 0 ]; then
        printf "%0.s " $(seq 1 $coloffset)
        printf "┏━━━━━━━━━━━━┓\n"
        printf "%0.s " $(seq 1 $coloffset)
        printf "┃ No Artwork!┃\n"
        printf "%0.s " $(seq 1 $coloffset)
        printf "┗━━━━━━━━━━━━┛\n"
    fi
    printf "%0.s\n" $(seq 1 "$l2")
    exit 1
fi
tput clear
sleep 1     # Don't wanna create a race condition
imgcat "$artfile"
tput cup 0,0
