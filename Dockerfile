FROM alpine:latest

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

RUN cd /tmp \
        && if [ "$(uname -m)" = "x86_64" ]; then \
               MYARCH="amd64"; \
           elif [ "$(uname -m)" = "arm64" ]; then \
               MYARCH="arm64"; \
           elif [ "$(uname -m)" = "armv7" ]; then \
               MYARCH="armv7"; \
           elif [ "$(uname -m)" = "i386" ] || [ "$(uname -m)" = "i686" ]; then \
               MYARCH="386"; \
           fi \
        && echo $MYARCH \
        && latest=$(wget -qO- -t1 -T2 https://api.github.com/repos/Mrs4s/go-cqhttp/releases/latest | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g') \
        && wget -q https://github.com/Mrs4s/go-cqhttp/releases/download/$latest/go-cqhttp_linux_$MYARCH.tar.gz -O go-cqhttp.tar.gz \
        && apk add --no-cache --update ffmpeg tzdata \
        && tar -zxvf go-cqhttp.tar.gz -C /usr/bin/ cqhttp --strip-components=1 \
        && rm go-cqhttp.tar.gz \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /data

ENTRYPOINT [ "/usr/bin/cqhttp" ]