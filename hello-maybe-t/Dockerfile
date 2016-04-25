FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get -q -y update \
    && apt-get \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        -q -y install \
        libgmp10

ADD .stack-work/install/x86_64-linux/lts-5.1/7.10.3/bin /usr/local/bin

CMD hello-maybe-t-app
