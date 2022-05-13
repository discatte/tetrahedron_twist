ffmpeg -i "wobbles - tetra twist%03d.png" \
       -i "wobble - tetra palette.png" \
       -lavfi "paletteuse=dither=bayer:diff_mode=rectangle" \
	   "wobbles - tetra twist - noopt.gif"