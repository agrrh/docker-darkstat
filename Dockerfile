FROM ubuntu:bionic as builder

RUN apt-get update \
  && apt-get install -y \
    autoconf \
    build-essential \
    curl \
    git \
    libpcap-dev \
    make \
    xxd \
    zlib1g-dev

RUN git clone https://www.unix4lyfe.org/git/darkstat /app \
  && cd /app \
  && autoheader \
  && autoconf \
  && ./configure \
  && make \
  && ls -lah ./

FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install -y \
    libpcap0.8 \
  && rm -rf /var/lib/apt/lists/* /var/cache/*

COPY --from=builder /app/darkstat /usr/sbin/darkstat

RUN usermod -u 99 nobody \
  && usermod -g 100 nobody \
  && mkdir -p /darkstat \
  && usermod -d /darkstat nobody \
  && chown -R nobody:users /darkstat \
  && chmod 755 -R /darkstat

WORKDIR /darkstat

ENV INTERFACE eth0
ENV UI_HOST 127.0.0.1
ENV UI_PORT 9666

CMD /usr/sbin/darkstat \
  --no-daemon \
  --chroot /darkstat \
  --user nobody \
  --import darkstat.db \
  --export darkstat.db \
  -i ${INTERFACE} \
  -p ${UI_PORT} \
  -b ${UI_HOST}
