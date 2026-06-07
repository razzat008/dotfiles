if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi


# Added by Antigravity CLI installer
export PATH="/home/ceaser/.local/bin:$PATH"
