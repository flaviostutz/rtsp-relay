# rtsp-relay
RTSP stream relay server with codec passthrough, so that no encoding will take place.
This is based on ffmpeg and https://github.com/aler9/rtsp-simple-server.

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
