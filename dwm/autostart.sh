#!/bin/sh
#
setxkbmap -option caps:escape_shifted_capslock
killall xcape 2>/dev/null ; xcape -e 'Caps_Lock=Escape'
#
# to increase the rate of anykey press 
# use xev -event keyboard to view keysym/keycode
xset r rate 300 40

# # for kdeconnect
# /usr/lib/kdeconnectd &
# kdeconnect-indicator &
#
# # nepali transliteratiooon
#    exec fcitx5 &
#
#
# #for wallpaper
#   exec nitrogen --restore --set-scaled &
#
#  # picom_config=$HOME/.config/picom/picom.conf
#    picom -b --config=/home/ceaser/.config/picom/picom.conf &
