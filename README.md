# mpdart


This is a quick script to display the embedded artwork song that is currently playing on MPD.
It does so by:

- Reading your .mpdconf file to determine the library location
- Getting the current song filename from mpc
- Extracting the image data with ffmpeg
- Calling imgcat to display the image in your terminal, or
- Displaying a short message about the lack of artwork


# Dependencies

- mpd (the entire point here is displaying mpd's current track)
- mpc
- ffmpeg
- imgcat (available from [here](https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat))
- tput (usually installed by default)


# TODO:

    - Read artwork directly from the file via byte offsets (abandon ffmpeg)
    - Read the folder.jpg/cover.jpg file that may exist in the directory
    - Figure out what's happening with mpc appending the track number to the end of the status line
    
