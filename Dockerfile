FROM jrottenberg/ffmpeg:3.3-alpine

EXPOSE 554
EXPOSE 8080

RUN apk update && \
  apk add --no-cache gettext

ENV SOURCE_URL ''
ENV STREAM_NAME 'stream'
ENV STREAM_VIDEO_CODEC ''
ENV STREAM_VIDEO_SIZE ''
ENV STREAM_VIDEO_FRAMERATE ''

COPY ffserver.conf.template /
COPY start-relay.sh /

ENTRYPOINT [ "/bin/sh" ]

CMD ["/start-relay.sh"]
