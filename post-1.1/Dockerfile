FROM gitlab-registry.oit.duke.edu/devops/containers/debian/buster:latest

ARG IIPSRV_GIT_COMMIT=d4a701864877cb22ec6212c284ccd733ce3106d8

# IIPImage variables
ENV LOGFILE   /dev/stdout
ENV VERBOSITY 1

RUN set -eux; \
	apt-get -y update; \
	apt-get -y install \
	autoconf \
	autotools-dev \
	cmake \
	curl \
	g++ \
	git \
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

RUN git clone https://github.com/uclouvain/openjpeg.git \
  && cd openjpeg \
  && git checkout v2.3.1 \
  && mkdir build \
  && cd build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make \
  && make install \
  && make clean

WORKDIR /opt/iipsrv

RUN set -eux; \
	curl -s -O https://automation.lib.duke.edu/iipsrv/post-1.1/${IIPSRV_GIT_COMMIT}.tar.gz; \
	curl -s https://automation.lib.duke.edu/iipsrv/post-1.1/${IIPSRV_GIT_COMMIT}.tar.gz.sha512 \
 	  | sha512sum -c - ; \
	tar -zxvf ${IIPSRV_GIT_COMMIT}.tar.gz; \
	rm ${IIPSRV_GIT_COMMIT}.tar.gz

RUN set -eux; \
	./autogen.sh; \
	./configure; \
	make

RUN set -eux; \
	useradd -u 1001 -m -N -g 0 -s /usr/sbin/nologin app-user; \
	mkdir -p -m 0444 /data; \
	ln -s /opt/iipsrv/src/iipsrv.fcgi /usr/local/bin/iipsrv.fcgi

VOLUME /data

EXPOSE 9000

HEALTHCHECK CMD nc -z localhost 9000

CMD [ "iipsrv.fcgi", "--bind", "0.0.0.0:9000" ]

USER 1001
