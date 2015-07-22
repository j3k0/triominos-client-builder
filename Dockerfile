FROM jeko/phusion-ssh
COPY build.sh /build.sh
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker.io && \
   rm -rf /var/lib/apt/lists/*
ENV ID_RSA= \
    ID_RSA_PUB=
VOLUME /artifacts
CMD /build.sh
