#!/usr/bin/env bash

BG_IMAGE=~/dotfiles/wallpapers/1261582.png
# BG_IMAGE=~/dotfiles/wallpapers/house.png
LOCKSCREEN_IMAGE=~/lockscreen.png
TEXT="Type password to unlock"
# default system sans-serif font
FONT=$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")
RESIZE=$(xdpyinfo | grep dimensions | cut -d\  -f7 | cut -dx -f1)
HUE=(-level "0%,100%,0.6")
EFFECT=(-filter Gaussian -resize 20% -define "filter:sigma=1.5" -resize 500.5%)

if [[ ! -f $LOCKSCREEN_IMAGE ]]; then
convert "$BG_IMAGE" \
    -resize "$RESIZE" \
    "${HUE[@]}" "${EFFECT[@]}" \
    -font "$FONT" -pointsize 26 -fill "white" \
    -gravity center -annotate +0+160 "$TEXT" \
    "$LOCKSCREEN_IMAGE"
fi

i3lock -i $LOCKSCREEN_IMAGE
systemctl suspend
