#!/bin/bash

#Usage
if [ "$#" -ge 1 ]; then
        if [ $1 = "-x" ]; then single=true
	else
                printf "Usage: mpdart [options]\n\nOptions:\n\t-x :\tPrint once and exit\n\n"
		exit 1
	fi
fi

# Feel free to adjust these as needed:
mpdconf="$HOME/.mpdconf"
mpddir="$HOME/.mpd"
artfile="$HOME/.ncmpcpp/.artwork.jpg"   # Feel free to change this value
read -r libprefix < $mpdconf		# NOTE: avoid using "~" in library location or this doesn't work
libprefix=${libprefix:25}       	# This assumes your ~/.mpdconf stays the same

while [ -e $mpddir/mpd.pid ]; do

	filename=$(mpc -f "%file%%track%" | head -n 1)
	# FIXME:  mpc seems to randomly put two weird characters on the end sometimes?
	ffmpeg -y -hide_banner -v -8 -i "${libprefix%$'\\"'}/${filename/%mp3*/mp3}" "$artfile"

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
	else
		tput clear
		imgcat "$artfile"	
	fi

	if [ $single ]; then exit 0 ; fi

	mpc idle player
done
