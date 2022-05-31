FROM instrumentisto/rust:nightly-bullseye-2022-01-03 AS builder
WORKDIR /roapi_src
COPY ./ /roapi_src
RUN apt-get update \
    && apt-get install --no-install-recommends -y cmake

RUN RUSTFLAGS='-C target-cpu=skylake' \
    cargo install --locked --features simd --path ./roapi-http --bin roapi-http

FROM debian:bullseye-slim
LABEL org.opencontainers.image.source https://github.com/roapi/roapi

RUN apt-get update && apt-get install -y libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*
COPY datasets /datasets
COPY config /config
COPY --from=builder /usr/local/cargo/bin/roapi-http /usr/local/bin/roapi-http

VOLUME ["/datasets","/config"]
EXPOSE 8084
CMD roapi-http -c ./config/roapi.yml