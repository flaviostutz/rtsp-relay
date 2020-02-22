FROM golang:1.13.8-alpine AS BUILD

RUN apk --update add git

#RTSP SIMPLE SERVER
WORKDIR /tmp
RUN git clone https://github.com/aler9/rtsp-simple-server.git
WORKDIR /tmp/rtsp-simple-server

RUN go mod download
RUN go build -o /go/bin/rtsp-simple-server .

#RTSP SIMPLE PROXY
WORKDIR /tmp
RUN git clone https://github.com/aler9/rtsp-simple-proxy.git
WORKDIR /tmp/rtsp-simple-proxy

RUN go mod download
RUN go build -o /go/bin/rtsp-simple-proxy .




FROM jrottenberg/ffmpeg:3.3-alpine

EXPOSE 8554
EXPOSE 8000
EXPOSE 8001
EXPOSE 8050
EXPOSE 8051

ENV SOURCE_URL ''
ENV STREAM_NAME 'stream'

RUN apk --update add gettext bash

COPY --from=BUILD /go/bin/rtsp-simple-server /bin/rtsp-simple-server
COPY --from=BUILD /go/bin/rtsp-simple-proxy /bin/rtsp-simple-proxy

ADD proxy.yml /tmp/proxy.yml
ADD start-relay.sh /

ENTRYPOINT [ "/bin/bash" ]

CMD ["/start-relay.sh"]
