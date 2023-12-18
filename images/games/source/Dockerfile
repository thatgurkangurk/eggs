FROM	--platform=$TARGETOS/$TARGETARCH debian:bullseye-slim

LABEL 	author="Gurkan" maintainer="hello@gurkz.me"

LABEL 	org.opencontainers.image.source="https://github.com/thatgurkangurk/eggs"
LABEL 	org.opencontainers.image.licenses=MIT

ENV 	DEBIAN_FRONTEND=noninteractive

RUN 	dpkg --add-architecture i386 \
	&& apt update \
	&& apt upgrade -y \
	&& apt install -y curl gcc tar g++ lib32gcc-s1 libgcc1 libcurl4-gnutls-dev:i386 libssl1.1:i386 libcurl4:i386 lib32tinfo6 libtinfo6:i386 lib32z1 lib32stdc++6 libncurses5:i386 libcurl3-gnutls:i386 libsdl2-2.0-0:i386 iproute2 gdb libsdl1.2debian libfontconfig1 telnet net-tools netcat tzdata \
	&& useradd -m -d /home/container container

USER	container
ENV 	USER=container HOME=/home/container
WORKDIR /home/container

COPY	./entrypoint.sh /entrypoint.sh
CMD		["/bin/bash", "/entrypoint.sh"]
