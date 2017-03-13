#!/bin/bash

read -r libprefix < "$HOME""/.mpdconf"
filename=$(mpc -f "%file%" | head -n 1)
#libprefix=${libprefix:25}       # This assumes your ~/.mpdconf stays the same
filestr=${libprefix%$'\"'}$filename
artfile="$HOME""/.ncmpcpp/.artwork.jpg"     # Feel free to change this value
ffmpeg -y -hide_banner -v -8 -i "${filestr}" "$artfile"
if [ $? -eq 1 ]; then
    voffset=$(tput lines)/2
    let voffset=$voffset-1
    tput clear 
    hoffset=$(tput cols)/2
    let hoffset=$hoffset-7  # The message box is 14 cols wide, so...
    printf "%0.s\n" $(seq 1 "$voffset")  #Kinda hacky but it works
    if [ $hoffset -gt 0 ]; then
        printf "%0.s " $(seq 1 $hoffset)
        printf "┏━━━━━━━━━━━━┓\n"
        printf "%0.s " $(seq 1 $hoffset)
        printf "┃ No Artwork!┃\n"
        printf "%0.s " $(seq 1 $hoffset)
        printf "┗━━━━━━━━━━━━┛\n"
    fi
    printf "%0.s\n" $(seq 1 "$voffset")
    exit 1
fi
tput clear
imgcat "$artfile"
#tput cup 0,0
