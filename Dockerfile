FROM debian:buster

ENV LOGFILE=syslog VERBOSITY=1

RUN apt-get -y update \
	&& apt-get -y install iipimage-server \
	&& apt-get -y clean

RUN groupadd -g 1001 appuser \
    	&& useradd -u 1001 -m -g 1001 appuser \
	&& mkdir -p -m 0444 /data
VOLUME /data

CMD ["/usr/lib/iipimage-server/iipsrv.fcgi", "--bind", "0.0.0.0:9000"]
