FROM golang:1.17-alpine AS builder

RUN go env -w GO111MODULE=auto \
  && go env -w CGO_ENABLED=0 \
  && git clone https://github.com/Mrs4s/go-cqhttp.git /build

WORKDIR /build

RUN set -ex \
    && cd /build \
    && go build -ldflags "-s -w -extldflags '-static'" -o cqhttp

FROM alpine:latest

RUN apk add --no-cache ffmpeg

COPY --from=builder /build/cqhttp /usr/bin/cqhttp
RUN chmod +x /usr/bin/cqhttp

WORKDIR /data

ENTRYPOINT [ "/usr/bin/cqhttp" ]