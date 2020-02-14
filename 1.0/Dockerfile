FROM debian:buster-slim

ENV LOGFILE=/dev/stdout
ENV VERBOSITY=1

RUN apt-get -y update \
	&& apt-get -y install iipimage-server \
	&& apt-get -y clean all

RUN groupadd -g 1001 appuser \
    && useradd -u 1001 -m -g 1001 appuser \
    && mkdir -p -m 0444 /data

VOLUME /data

EXPOSE 9000

CMD ["/usr/lib/iipimage-server/iipsrv.fcgi", "--bind", "0.0.0.0:9000"]

USER 1001
