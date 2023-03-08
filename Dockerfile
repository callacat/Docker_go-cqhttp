FROM alpine:latest

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

RUN cd /tmp \
    && ARCH=$(uname -m)
       case $ARCH in
           x86_64) MYARCH="amd64";;
           arm64)  MYARCH="arm64";;
           armv7*) MYARCH="armv7";;
           i386|i686) MYARCH="i386";;
           ppc|ppc64) MYARCH="ppc";;
           mips|mips64) MYARCH="mips";;
           sparc|sparc64) MYARCH="sparc";;
           *) MYARCH="unknown";;
       esac \
    && latest=$(wget -qO- -t1 -T2 https://api.github.com/repos/Mrs4s/go-cqhttp/releases/latest | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g') \
    && wget -q https://github.com/Mrs4s/go-cqhttp/releases/download/$latest/go-cqhttp_linux_$MYARCH.tar.gz -O go-cqhttp.tar.gz \
    && apk add --no-cache --update ffmpeg tzdata \
    && tar -zxvf go-cqhttp.tar.gz -C /usr/bin/ cqhttp --strip-components=1 \
    && rm go-cqhttp.tar.gz \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime

WORKDIR /data

ENTRYPOINT [ "/usr/bin/cqhttp" ]