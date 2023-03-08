FROM alpine:latest

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

RUN if [ "$(apk --print-arch)" = "x86_64" ]; then \
        MYARCH="amd64"; \
    elif [ "$(apk --print-arch)" = "aarch64" ]; then \
        MYARCH="arm64"; \
    elif [ "$(apk --print-arch)" = "armhf" ]; then \
        MYARCH="armv7"; \
    elif [ "$(apk --print-arch)" = "i386" ]; then \
        MYARCH="386"; \
    else \
        echo "Unknown architecture"; \
        exit 1; \
    fi \
    && echo $MYARCH \
    && apk add --no-cache tzdata ffmpeg \
    && latest=$(wget -qO- -t1 -T2 https://api.github.com/repos/Mrs4s/go-cqhttp/releases/latest | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g') \
    && wget https://github.com/Mrs4s/go-cqhttp/releases/download/$latest/go-cqhttp_linux_$MYARCH.tar.gz -O go-cqhttp.tar.gz \
    && tar -zxvf go-cqhttp.tar.gz -C /usr/bin/ cqhttp --strip-components=1 \
    && rm go-cqhttp.tar.gz \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /data

ENTRYPOINT [ "/usr/bin/cqhttp" ]