FROM alpine:edge as builder
ARG VERSION=v1.0.2
ENV CLONE_URL https://github.com/mimblewimble/grin.git
WORKDIR /src
RUN apk update && apk --no-cache add git cargo rust ncurses-dev zlib-dev llvm-dev openssl-dev linux-headers pkgconfig clang-dev && git clone $CLONE_URL -b $VERSION . && cargo build --release 

FROM alpine
RUN apk --no-cache add ncurses libgcc
COPY --from=builder /src/target/release/grin /usr/local/bin/grin
WORKDIR /root/.grin
RUN grin server config && sed -i -e 's/run_tui = true/run_tui = false/' grin-server.toml

VOLUME ["/root/.grin"]
EXPOSE 3413 3414 3415 3416
ENTRYPOINT ["grin"]
CMD ["server", "run"]
