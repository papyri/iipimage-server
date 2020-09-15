#
# IIPImage Server 1.0 container image
#
FROM gitlab-registry.oit.duke.edu/devops/containers/debian/buster-slim:latest

ENV LOGFILE   /dev/stdout
ENV VERBOSITY 1

RUN set -eux; \
	apt-get -y update; \
	apt-get -y upgrade; \
	apt-get -y --no-install-recommends install \
	  iipimage-server \
	  ncat \
	; \
	apt-get -y clean; \
	rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	useradd -u 1001 -m -N -g 0 -s /usr/sbin/nologin app-user; \
	mkdir -p -m 0444 /data

VOLUME /data

EXPOSE 9000

HEALTHCHECK CMD nc -z localhost 9000

CMD [ "/usr/lib/iipimage-server/iipsrv.fcgi", "--bind", "0.0.0.0:9000" ]

USER 1001
