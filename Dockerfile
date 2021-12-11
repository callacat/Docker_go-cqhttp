FROM alpine:latest

ENV TZ=Asia/Shanghai
ENV LANG C.UTF-8

RUN apk add --no-cache ffmpeg

ADD https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta8-fix2/go-cqhttp_linux_amd64.tar.gz /usr/bin/cqhttp
RUN chmod +x /usr/bin/cqhttp

WORKDIR /data

CMD [ "/usr/bin/cqhttp" ]
