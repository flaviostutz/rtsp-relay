FROM jrottenberg/ffmpeg:3.3

COPY ffserver.conf.template /
COPY start-relay.sh /

ENTRYPOINT ["/start-relay.sh"]

