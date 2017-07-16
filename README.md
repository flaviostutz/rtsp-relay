# rtsp-relay
RTSP relay server based on ffmpeg and ffserver

## Usage
   docker run -p 554:554 stutzlab/rtsp-relay [source media url] [rtsp stream name] [stream dimensions] [stream codec] [stream framerate]

## Example
   docker run -p 8554:554 stutzlab/rtsp-relay rtsp://upstreamserver/mysource mystream"
   access it using url 'rtsp://dockerhost:8554/mystream'"

## TODO
There is one major improvement I really need right now that is the ability to relay rtsp streams without reencoding, so that cpu would be greatly reduced even when dozens of clients are connected. I managed to do this on Windows VLC, but could not get this on Linux based VLC (arrrrgh!). Help is really needed here!

