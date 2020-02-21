# rtsp-relay
RTSP stream relay server with codec passthrough, so that no encoding will take place.
This is based on ffmpeg and ffserver.

## Usage

* create docker-compose.yml

```yml
version: '3.7'

services:

  rtsp-relay:
    image: flaviostutz/rtsp-relay
    ports: 
      - 554:554
      - 9090:8080
    restart: always
    environment:
        - SOURCE_URL=http://ip-thomasmarina.greatlakescam.com/user/cgi-bin/getstream.cgi?10&&&&0&0&0&0&0
```

* VLC -> File -> Open Network... -> URL "rtsp://localhost:554/stream" -> Open

* The restreamed image may appear


## TODO
There is one major improvement I really need right now that is the ability to relay rtsp streams without reencoding, so that cpu would be greatly reduced even when dozens of clients are connected. I managed to do this on Windows VLC, but could not get this on Linux based VLC (arrrrgh!). Help is really needed here!

