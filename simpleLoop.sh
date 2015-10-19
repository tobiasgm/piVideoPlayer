#!/bin/sh

# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# blank terminal after 1 min
setterm -blank 1

# set here the path to the directory containing your videos
VIDEOPATH="/media/usb0"

# you can normally leave this alone
SERVICE="omxplayer"

while true; do
    if ps ax | grep -v grep | grep $SERVICE  > /dev/null
    then
	echo "running"  >> /dev/null
    else
        for file in $VIDEOPATH/*; do
	clear
        omxplayer -r "${file}" > /dev/null
        done

    fi
done




