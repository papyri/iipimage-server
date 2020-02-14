FROM debian:bullseye-slim

ENV LOGFILE=/dev/stdout
ENV VERBOSITY=1

RUN apt-get -y update \
  && apt-get -y install git build-essential cmake liblcms2-dev libtiff-dev libpng-dev libz-dev

RUN git clone https://github.com/uclouvain/openjpeg.git \
  && cd openjpeg \
  && git checkout v2.3.1 \
  && mkdir build \
  && cd build \
  && cmake .. -DCMAKE_BUILD_TYPE=Release \
  && make \
  && make install \
  && make clean

RUN apt-get -y install iipimage-server \
	&& apt-get -y clean all

RUN groupadd -g 1001 appuser \
    && useradd -u 1001 -m -g 1001 appuser \
    && mkdir -p -m 0444 /data

VOLUME /data

EXPOSE 9000

CMD ["/usr/lib/iipimage-server/iipsrv.fcgi", "--bind", "0.0.0.0:9000"]

USER 1001
