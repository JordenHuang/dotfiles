#!/usr/bin/env bash

# From: https://github.com/i3/i3/discussions/6356

notify() { dunstify -r 1003 -a toggle "$@" ;}

toggle() {
	device=$(xinput --list --name-only | grep -i "$1") device=${device#∼ }
	state=$(xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$")

	if [ "$state" = 1 ]; then
		xinput disable "$device"
		notify -i touchpad-disabled-symbolic "$1 Disabled"
	else
		xinput enable "$device"
		notify -i touchpad-enabled-symbolic "$1 Enabled"
	fi
}

toggle TouchPad
