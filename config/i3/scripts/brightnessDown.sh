#!/bin/sh
file="/sys/class/backlight/nvidia_0/brightness"
actualBrightness=$(cat "$file")
newBrightness=$((actualBrightness - 20))
if [[ newBrightness -gt 5 ]]; then
	echo $newBrightness >> $file
fi
