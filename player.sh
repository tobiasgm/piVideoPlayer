#!/bin/bash

#omxplayer --win "0 0 800 600" -o hdmi /home/pi/piface_test/piface/trailer_480p.mov < /tmp/cmd
file=$1
omxplayer --win "0 0 800 400" -o hdmi $file < /tmp/cmd