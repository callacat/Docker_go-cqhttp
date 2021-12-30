FROM alpine:latest

ENV TZ=Asia/Shanghai
ENV LANG C.UTF-8

ADD https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta8-fix2/go-cqhttp_linux_amd64.tar.gz /tmp/go-cqhttp_linux_amd64.tar.gz
RUN apk add --no-cache ffmpeg && apk add --no-cache tzdata \
    && cd /tmp && tar -zxvf go-cqhttp_linux_amd64.tar.gz \
    && mv go-cqhttp /usr/bin/cqhttp && chmod +x /usr/bin/cqhttp \
    && rm /tmp/* \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime
WORKDIR /data
ENTRYPOINT [ "/usr/bin/cqhttp" ]
