# rtsp-relay
RTSP stream relay server with codec passthrough, so that no encoding will take place and low CPU will be used.

Any input URL handled by ffmpeg can be used, but keep in mind that no transcoding will take place to the output rtsp stream.

Multiple clients can connect to the same stream.

This is based on ffmpeg, https://github.com/aler9/rtsp-simple-server and https://github.com/aler9/rtsp-simple-proxy.

Exposed ports:

* RTSP UDP/TCP listener: 8554
* RTP UDP listener: 8000
* RTCP UDP listener: 8001


## Usage

* create docker-compose.yml

```yml
version: '3.7'

services:

  rtsp-relay:
    image: flaviostutz/rtsp-relay
    ports:
      - 8554:8554
    restart: always
    environment:
        - SOURCE_URL=http://ip-thomasmarina.greatlakescam.com/user/cgi-bin/getstream.cgi?10&&&&0&0&0&0&0
```

* VLC -> File -> Open Network... -> URL "rtsp://localhost:8554/stream" -> Open

* The restreamed image may appear

## ENVs

* SOURCE_URL - source media URL to be used as input for RTSP stream. Cannot be empty
* RTSP_PROXY_SOURCE_TCP - whetever source RTSP stream is UDP ('no') or TCP ('yes'). defaults to no
* STREAM_NAME - path for "rtsp://[host]:[port]/[STREAM_NAME]. default to 'stream'
* FORCE_FFMPEG_SOURCE - use RTSP proxy when in/out (false) are RTSP streams or force to use FFMPEG restream even in this case (true). defaults to false. use for CPU usage comparisons
* FFMPEG_ARGS - additional arguments to ffmpeg publisher. ex: "-err_detect aggressive -fflags discardcorrupt"
* FFMPEG_INPUT_ARGS - ffmpeg args applied near input params. ex.: '-v 10'. defaults to ''
* FFMPEG_OUTPUT_ARGS - ffmpeg args applied near output params. ex.: '-vcodec h264'. defaults to '-c copy' so that no transcoding will be done by default.

## Tips

* If you wish to create an RTSP feed from a video file in loop

  * Place the video file in directory 'samples'

  * Create docker-compose.yml:

```yml
  rtsp-relay:
    image: flaviostutz/rtsp-relay
    ports:
        - 8554:8554
    environment:
        - SOURCE_URL=file:///samples/cars1.mp4
    volumes:
        - ./samples:/samples
```

  * Run docker-compose up

  * Connect your RTSP client (VLC etc)

