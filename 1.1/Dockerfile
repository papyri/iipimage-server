FROM gitlab-registry.oit.duke.edu/devops/containers/debian/buster:latest

# IIPImage variables
ENV LOGFILE   /dev/stdout
ENV VERBOSITY 1

# Workaround for bug in IIPImage v1.1 release
# https://duldev.atlassian.net/browse/DDR-2144
# https://duldev.atlassian.net/browse/DDR-2048
# ENV EMBED_ICC 0

RUN set -eux; \
	apt-get -y update; \
	apt-get -y install \
	autoconf \
	autotools-dev \
	curl \
	g++ \
	libfcgi-dev \
	libjpeg-dev \
	libmemcached-dev \
	libopenjp2-7-dev \
	libtiff-dev \
	libtool \
	make \
	ncat \
	pkg-config \
	zlib1g-dev \
	; \
	apt-get -y clean; \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

# Creates /usr/src/iipsrv-iipsrv-1.1/src/iipsrv.fcgi
RUN set -eux; \
	curl -s -O https://automation.lib.duke.edu/iipsrv/1.1/iipsrv-1.1.tar.gz; \
	curl -s https://automation.lib.duke.edu/iipsrv/1.1/iipsrv-1.1.tar.gz.sha512 \
	  | sha512sum -c - \
	  ; \
	tar -zxvf iipsrv-1.1.tar.gz

WORKDIR /usr/src/iipsrv-iipsrv-1.1

RUN set -eux; \
	./autogen.sh; \
	./configure; \
	make

RUN set -eux; \
	useradd -u 1001 -m -N -g 0 -s /usr/sbin/nologin app-user; \
	mkdir -p -m 0444 /data; \
	ln -s /usr/src/iipsrv-iipsrv-1.1/src/iipsrv.fcgi /usr/local/bin/iipsrv.fcgi

VOLUME /data

EXPOSE 9000

HEALTHCHECK CMD nc -z localhost 9000

CMD [ "iipsrv.fcgi", "--bind", "0.0.0.0:9000" ]

USER 1001
