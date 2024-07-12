#!/usr/bin/env bash
systemctl --user import-environment DISPLAY

#for fonts/colors etc
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

#simple x hotkey daemon
# sxhkd -c ~/.config/sxhkd/sxhkdrc &

# map caps lock button as escape button
setxkbmap -option caps:escape_shifted_capslock

#but when it is pressed once, treat it as escape
#killall xcape 2>/dev/null ; xcape -e 'Caps_Lock=Escape'

# to increase the rate of anykey press 
# use xev -event keyboard to view keysym/keycode
xset r rate 300 40

#status bars for dwm
exec slstatus &
#exec dwmblocks &

#policykit gui
# polit_exec=/usr/lib/xfce-polkit/xfce-polkit
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#if [[ "$(pidof xfce-polkit)" ]]; then
#  echo " xfce4-polkit is running"
#else
#  echo "starting xfce-polkit"
#  exec /usr/lib/xfce-polkit/xfce-polkit &
#fi


# run flameshot daemon
if [[ "$(pidof flameshot)" ]]; then
  echo " flameshot is running"
else
  echo "starting flameshot"
  exec flameshot &
fi

#xfce4-panel
# xfce4-panel --disable-wm-check
#bash ~/.scripts/bash_scripts/e.sh &

#for wallpaper
if [[ $(pidof nitrogen) ]]; then
 echo "nitrogen is running"
else
 echo "starting"
 exec nitrogen --restore --set-scaled &
fi


#compositor

 # picom_config=$HOME/.config/picom/picom.conf
if [[ "$(pidof picom)" ]]; then
 echo "picom is already running"
else
 echo "starting picom"
  picom -b --config=/home/ceaser/.config/picom/picom.conf &
fi


#window managers
#awesome windowmanager
# exec awesome



#notification daemon
if [[ "$(pidof dunst)"  ]]; then
 echo "dunst is running"
else
 echo "starting dunst daemon"
exec dunst -config ~/.config/dunst/dunstrc &
fi
# if [[ -z $(pidof dunst) ]]; then
#   $(dunst -config $dunst_config &)
# fi


# lock screen
# xautolock -time 1 -locker slock
# xautolock -time 1 -locker "systemctl suspend" -detectsleep

# MPD daemon start (if no other user instance exists)
#[ ! -s ~/.config/mpd/pid ] && mpd
#if [[ "$(pidof mpd)" ]]; then
#  echo "mpd is running"
#else
#  echo "starting mpd daemon"
#  exec mpd &
#fi

#to start kdeconnect daemon and indicator
# /usr/lib/kdeconnectd &
# kdeconnect-indicator &
#
#for prime
#/usr/bin/prime-offload
#
#dynamic window manager-by suckless
#to update dwm without closing the running apps
#
while type dwm >/dev/null; do dwm && continue || break; done
