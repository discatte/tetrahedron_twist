ffmpeg -i "wobbles - tetra twist%03d.png" \
      -vf "palettegen=stats_mode=diff:max_colors=32"
	  "wobble - tetra palette.png"