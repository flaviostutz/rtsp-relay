#!/bin/bash

set -e

if [ "$SOURCE_URL" == "" ]; then
   echo "'SOURCE_URL' cannot be empty"
   exit 1
fi


echo "Starting rtsp server daemon..."
rtsp-simple-server &
sleep 2

echo "Start relaying from $SOURCE_URL to RTSP at rtsp://0.0.0.0:8554/$STREAM_NAME"
ffmpeg -i $SOURCE_URL -c copy -f rtsp rtsp://127.0.0.1:8554/$STREAM_NAME
