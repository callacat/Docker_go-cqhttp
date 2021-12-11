FROM alpine:latest

ENV TZ=Asia/Shanghai
ENV LANG C.UTF-8

RUN apk add --no-cache ffmpeg

WORKDIR /data

ADD https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta8-fix2/go-cqhttp_linux_amd64.tar.gz /data/go-cqhttp_linux_amd64.tar.gz
RUN cd /data \
    && tar -zxvf go-cqhttp_linux_amd64.tar.gz \
    && mv go-cqhttp cqhttp && chmod +x cqhttp \
    && rm go-cqhttp_linux_amd64.tar.gz && rm README.md && ls

CMD [ "/data/cqhttp" ]
