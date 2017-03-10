#!/bin/bash
recordingFilename=$(date | md5sum | awk '{print $1}')
arecord -D plughw:1 -d 10 -f cd "/tmp/${recordingFilename}.wav" --max-file-time 30 &>/dev/null
echo "/tmp/${recordingFilename}.wav"

