if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

export PATH="${PATH}:/home/ceaser/.local/bin/"

