FROM alpine:latest

RUN apk update  && apk add gmp

ADD .stack-work/install/x86_64-linux/lts-5.12/7.10.3/bin /usr/local/bin

CMD hello-app
