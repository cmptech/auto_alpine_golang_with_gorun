#FROM alpine:edge
FROM cmptech/auto_alpine_edge

Maintainer Wanjo Chan ( http://github.com/wanjochan/ )

COPY repositories /etc/apk/

RUN apk update && apk upgrade

RUN apk add wget openssl curl git

RUN cd /tmp/ \
&& apk --no-cache add ca-certificates \
&& wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-2.23-r1.apk \
&& apk --allow-untrusted add glibc-2.23-r1.apk

RUN rm -rf /var/cache/apk/*

RUN mkdir /goroot/ \
&& mkdir /gopath/ \
&& cd /tmp/ \
&& wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz \
&& tar xzvf go1.6.linux-amd64.tar.gz \
&& cp -Rf go/* /goroot/ \
&& rm -rf /tmp/* 

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN cd /gopath/ && go get github.com/erning/gorun

#ENV PATH $PATH:/goroot

#RUN /goroot/go version


