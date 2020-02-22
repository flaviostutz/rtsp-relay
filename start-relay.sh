#!/bin/bash

set -e

if [ "$SOURCE_URL" == "" ]; then
   echo "'SOURCE_URL' cannot be empty"
   exit 1
fi

if [[ $SOURCE_URL == rtsp://* ]] && [ "$FORCE_FFMPEG" == "false" ]; then
   envsubst < /tmp/proxy.yml > /proxy.yml
   echo "/proxy.yml"
   cat /proxy.yml
   echo "Starting rtsp proxy from $SOURCE_URL to rtsp://0.0.0.0:8554/$STREAM_NAME..."
   rtsp-simple-proxy /proxy.yml

else
   echo "Starting rtsp server for custom source URL..."
   rtsp-simple-server &
   sleep 2

   echo "Start relaying from $SOURCE_URL to rtsp://0.0.0.0:8554/$STREAM_NAME"
   while true; do
      ffmpeg -i $SOURCE_URL -c copy -f rtsp rtsp://127.0.0.1:8554/$STREAM_NAME
      echo "Reconnecting..."
      sleep 1
   done
fi
