#!/bin/bash

SLEEP_TIME=1


#Choose between MP3s or Playlists
USEFILES=0

if [ $RANDOM -gt 16000 ] ; then USEFILES=1; fi


#amixer set Speaker mute

sleep 10

mpc stop
mpc clear
mpc volume 0


#Choose between MP3s or Playlists
if [ $USEFILES -eq 0 ]
then
    echo "Using playlists"
    mpc lsplaylists | shuf -n 1 | mpc load
else
    echo "Using files"
    mpc listall | mpc add
fi

mpc play

sleep 1

mpc volume 0

#amixer set Speaker unmute

for i in {0..70..1}
do
    sleep $SLEEP_TIME
    mpc volume $i
done
