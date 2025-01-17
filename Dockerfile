FROM frolvlad/alpine-glibc:latest as build

ARG MYRIAD_VERSION=0.5.0.3
ARG GHC_VERSION=8.8.3

RUN apk add --no-cache curl tar gzip docker openrc
WORKDIR /tmp/myriad
RUN curl -OL https://github.com/1Computer1/myriad/releases/download/${MYRIAD_VERSION}/myriad-${MYRIAD_VERSION}-Linux-${GHC_VERSION}.tar.gz && \
    tar -xzf myriad-${MYRIAD_VERSION}-Linux-${GHC_VERSION}.tar.gz && \
    rm -f myriad-${MYRIAD_VERSION}-Linux-${GHC_VERSION}.tar.gz && \
    service --status-all 

FROM frolvlad/alpine-glibc:latest
RUN apk add --no-cache docker-cli gmp
WORKDIR /opt/myriad
COPY --from=build /tmp/myriad .

EXPOSE 8081

ENTRYPOINT ["./myriad"]
