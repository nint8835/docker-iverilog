FROM debian:stretch as builder

LABEL \
      com.github.nint8835.docker.dockerfile="Dockerfile" \
      com.github.nint8835.vcs-type="Git" \
      com.github.nint8835.vcs-url="https://github.com/nint8835/docker-iverilog.git"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install -y \
        automake \
        autoconf \
        gperf \
        build-essential \
        flex \
        bison \
        git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/steveicarus/iverilog && \
    cd iverilog && \
    bash autoconf.sh && \
    ./configure && \
    make && \
    make install && \
    cd && \
    rm -rf iverilog

FROM debian:stretch

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib /usr/local/lib
