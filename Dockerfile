FROM debian:buster

ENV LOGFILE=syslog VERBOSITY=1

RUN apt-get -y update \
	&& \
	apt-get -y install iipimage-server \
	&& \
	apt-get -y clean

RUN mkdir -p -m 0444 /data
VOLUME /data

CMD ["iipsrv.fcgi", "--bind", "0.0.0.0:9000"]
