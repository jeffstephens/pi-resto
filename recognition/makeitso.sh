#!/bin/bash

argc=$#

if [ $argc == 0 ]; then
	# record audio sample
	echo "Capturing audio sample..."
	audioSample=$(./capture-audio.sh)
elif [ $argc == 1 ]; then
	# use existing audio sample
	echo "Using existing audio sample..."

	if [ -f $1 ]; then
		audioSample=$1
	else
		echo "File ${1} doesn't exist."
		exit 2
	fi
else
	echo "Usage: ${0} [pathToAudioSample]"
	exit 1
fi

# upload sample to service for identification
echo "Identifying audio sample..."
audioInfo=$(python identify-audio.py $audioSample)

# display current track name and artist on Sense HAT
echo "Publishing results..."
echo $audioInfo | python printResult.py

recognitionResult=$?
if [ $recognitionResult -ne 0 ]; then
	echo "Failed to recognize song."
	echo $audioInfo | python printResult.py | python scrollError.py
	exit 2
else
	echo $audioInfo | python printResult.py | python scrollMessage.py
fi


# scrobble the track if it's different than the last one we scrobbled
scrobbleHash=$(echo $audioInfo | python printResult.py | md5sum)
echo $scrobbleHash > tempHash.txt
scrobbleHashFile="last-scrobble.txt"

if [ ! -f $scrobbleHashFile ]; then
	touch $scrobbleHashFile
fi

if diff tempHash.txt $scrobbleHashFile >/dev/null; then
	echo "Not scrobbling a duplicate"
else
	echo "Scrobbling track..."
	source ../setup/lastfm_creds.sh
	echo $audioInfo | python scrobbleTrack.py
	echo $scrobbleHash > $scrobbleHashFile
fi

