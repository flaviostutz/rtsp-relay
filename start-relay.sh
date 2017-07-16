#!/bin/bash

SOURCE_URL=$1
STREAM_NAME=$2
STREAM_VIDEO_SIZE=$3
STREAM_VIDEO_CODEC=$4
STREAM_VIDEO_FRAMERATE=$5

if [ "$SOURCE_URL" == "" ]; then
   echo "Usage "
   echo "  docker run -p 554:554 stutzlab/rtsp-relay [source media url] [rtsp stream name] [stream dimensions] [stream codec] [stream framerate] "
   echo "  Example:"
   echo "     docker run -p 554:8554 stutzlab/rtsp-relay rtsp://upstreamserver/mysource mystream"
   echo "     then access it using url 'rtsp://dockerhost:8554/mystream'"
   exit 1
fi

if [ "$STREAM_NAME" == "" ]; then
   STREAM_NAME="stream"
fi

if [ "$STREAM_VIDEO_SIZE" == "" ]; then
   STREAM_VIDEO_SIZE="1024x768"
fi

if [ "$STREAM_VIDEO_CODEC" == "" ]; then
   STREAM_VIDEO_CODEC="libx264"
fi

if [ "$STREAM_VIDEO_FRAMERATE" == "" ]; then
   STREAM_VIDEO_FRAMERATE="15"
fi

echo "Preparing ffserver configurations"
cp /ffserver.conf.template /etc/ffserver.conf
sed -i -e "s/<STREAM_NAME>/${STREAM_NAME}/g" /etc/ffserver.conf
sed -i -e "s/<STREAM_VIDEO_SIZE>/${STREAM_VIDEO_SIZE}/g" /etc/ffserver.conf
sed -i -e "s/<STREAM_VIDEO_CODEC>/${STREAM_VIDEO_CODEC}/g" /etc/ffserver.conf
sed -i -e "s/<STREAM_VIDEO_FRAMERATE>/${STREAM_VIDEO_FRAMERATE}/g" /etc/ffserver.conf

echo "Starting ffserver daemon"
more /etc/ffserver.conf
ffserver -d&

echo "Start relaying from $SOURCE_URL to RTSP rtsp://localhost:554/$SERVER_STREAM"
ffmpeg -i $SOURCE_URL -rtsp_transport tcp http://localhost:8080/feed1.ffm

