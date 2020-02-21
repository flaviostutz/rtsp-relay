FROM golang:1.13.8-alpine AS BUILD

RUN apk --update add git

WORKDIR /tmp
RUN git clone https://github.com/aler9/rtsp-simple-server.git
WORKDIR /tmp/rtsp-simple-server

RUN go mod download
RUN go build -o /go/bin/rtsp-simple-server .



FROM jrottenberg/ffmpeg:3.3-alpine

EXPOSE 8554
EXPOSE 8000
EXPOSE 8001

ENV SOURCE_URL ''
ENV STREAM_NAME 'stream'

COPY --from=BUILD /go/bin/rtsp-simple-server /bin/rtsp-simple-server

COPY start-relay.sh /

ENTRYPOINT [ "/bin/sh" ]

CMD ["/start-relay.sh"]
