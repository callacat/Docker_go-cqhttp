FROM alpine:latest

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

RUN cd /tmp \
        && MYARCH=$(cat apk --print-arch) \
        && cheo $MYARCH \
        && add --no-cache tzdata ffmpeg \
        && latest=$(wget -qO- -t1 -T2 https://api.github.com/repos/Mrs4s/go-cqhttp/releases/latest | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g') \
        && wget -q https://github.com/Mrs4s/go-cqhttp/releases/download/$latest/go-cqhttp_linux_$MYARCH.tar.gz -O go-cqhttp.tar.gz \
        && tar -zxvf go-cqhttp.tar.gz -C /usr/bin/ cqhttp --strip-components=1 \
        && rm go-cqhttp.tar.gz \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /data

ENTRYPOINT [ "/usr/bin/cqhttp" ]