FROM alpine:latest

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

RUN cd /tmp \
    && a=arm64 \
        if [[ $(uname -a | grep "x86_64") != "" ]]; then \
            a=amd64 && cp /usr/share/zoneinfo/$TZ /etc/localtime \
        fi ; \
    && latest=$(wget -qO- -t1 -T2 https://api.github.com/repos/Mrs4s/go-cqhttp/releases/latest | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g') \
    && wget -q https://github.com/Mrs4s/go-cqhttp/releases/download/$latest/go-cqhttp_linux_$a.tar.gz \
    && apk add --no-cache ffmpeg tzdata \
    && tar -zxvf go-cqhttp_linux_$a.tar.gz \
    && mv go-cqhttp /usr/bin/cqhttp && chmod +x /usr/bin/cqhttp \
    && rm /tmp/*
    
WORKDIR /data
ENTRYPOINT [ "/usr/bin/cqhttp" ]
