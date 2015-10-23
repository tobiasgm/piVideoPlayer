 #!/bin/bash

# global declarations

button0=200
button1=201
button2=202
button3=203

gpio load spi

file="/home/pi/piface_test/piface/trailer_480p.mov"
pipe="/tmp/cmd"


# create the pipe if it does not exist
if [ ! -p $pipe ]; then 
	mkfifo $pipe
	echo "pipe created"
fi


#sh player.sh  $file >&- &2>-&
sh player.sh $file &
echo "Player armed"


# setup:
#	Program the GPIO correctly
#######################################################################

setup ()
{
  echo "setup"
  gpio -p mode $button0 up
  gpio -p mode $button1 up
  gpio -p mode $button2 up
  gpio -p mode $button3 up

}
 
# waitButton:
#	Wait for the button to be pressed. Because we have the GPIO
#	pin pulled high, we wait for it to go low to indicate a push.
#######################################################################

checkButton ()
{
  #echo -n "Waiting for button ... "
  if [ `gpio -p read $button0` = 0 ]; then
      omxPlay
  elif [ `gpio -p read $button1` = 0 ]; then
      omxPause
  elif [ `gpio -p read $button2` = 0 ]; then
      omxStop
  elif [ `gpio -p read $button3` = 0 ]; then
      omxStatus
  fi
}

# 
#######################################################################

omxPlay ()
{
    echo "play button pressed"
    echo -n . > /tmp/cmd	
    sleep 1 

}

# 
#######################################################################

omxPause ()
{
    echo "pause button pressed"
    echo -n p > /tmp/cmd
    sleep 1   
}

# 
#######################################################################

omxStop ()
{
    echo "stop button pressed"
    echo -n q > /tmp/cmd

}

# 
#######################################################################

omxStatus ()
{
 echo -n z > /tmp/cmd
}


#
#######################################################################

setup 
while true;
do
checkButton
done

