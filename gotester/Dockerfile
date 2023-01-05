FROM golang:1.19.4-alpine3.16

LABEL org.opencontainers.image.source https://github.com/codingric/builders

WORKDIR /build

RUN apk --no-cache add make curl gcc musl-dev

#ENTRYPOINT ["go", "test", "./...", "-gcflags=all=-l", "-v"]