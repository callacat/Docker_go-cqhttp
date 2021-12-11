FROM alpine:latest

RUN apk add --no-cache ffmpeg

ADD https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta8-fix2/go-cqhttp_linux_amd64.tar.gz /usr/bin/cqhttp
RUN cd /usr/bin && ls && chmod +x /usr/bin/cqhttp

WORKDIR /data

ENTRYPOINT [ "/usr/bin/cqhttp" ]