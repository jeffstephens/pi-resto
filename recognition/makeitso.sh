#!/bin/bash

argc=$#

if [ $argc == 0 ]; then
	# record audio sample
	echo "Capturing audio sample..."
	audioSample=$(./capture-audio.sh)
elif [ $argc == 1 ]; then
	# use existing audio sample
	echo "Using existing audio sample..."
	audioSample=$1
else
	echo "Usage: ${0} [pathToAudioSample]"
	exit 1
fi

# upload sample to service for identification
echo "Identifying audio sample..."
audioInfo=$(python identify-audio.py $audioSample)

# publish results to Last.fm and Twitter
echo "Publishing results..."
echo $audioInfo | python printResult.py
echo $audioInfo | python scrobbleTrack.py
echo $audioInfo | python tweetTrack.py

