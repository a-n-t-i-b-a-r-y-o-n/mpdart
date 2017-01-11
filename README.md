# mpdart


This is a quick script to display the song that is currently playing on MPD.
It does so by:

- Reading your .mpdconf file to determine the library location
- Getting the current song filename from mpc
- Extracting the image data with ffmpeg
- Calling imgcat to display the image in your terminal, or
 - Displaying a short message about the lack of artwork



# TODO:

    - Read artwork directly from the file via byte offsets (abandon ffmpeg)

    
