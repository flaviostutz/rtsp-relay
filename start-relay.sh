#!/bin/bash

set -e

if [ "$SOURCE_URL" == "" ]; then
   echo "'SOURCE_URL' cannot be empty"
   exit 1
fi

echo "Preparing ffserver configurations"
envsubst < /ffserver.conf.template > /etc/ffserver.conf

if [ "$STREAM_CODEC" == "" ]; then
   sed -i -e "s/VideoCodec/#VideoCodec/g" /etc/ffserver.conf
fi
if [ "$STREAM_VIDEO_SIZE" == "" ]; then
   sed -i -e "s/VideoSize/#VideoSize/g" /etc/ffserver.conf
fi
if [ "$STREAM_VIDEO_FRAMERATE" == "" ]; then
   sed -i -e "s/VideoFrameRate/#VideoFrameRate/g" /etc/ffserver.conf
fi

echo "/etc/ffserver.conf"
more /etc/ffserver.conf

echo "Starting ffserver daemon..."
echo "Status page at http://:8080/stats.html"
ffserver &

echo "Start relaying from $SOURCE_URL to RTSP rtsp://[dockerhost]:554/$STREAM_NAME"
ffmpeg -i $SOURCE_URL -rtsp_transport tcp http://127.0.0.1:8080/feed1.ffm

