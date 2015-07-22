FROM jeko/phusion-ssh
COPY build.sh /build.sh
ENV ID_RSA= \
    ID_RSA_PUB=
VOLUME /artifacts
RUN /build.sh
