FROM ubuntu:16.04
LABEL Maintainer="Pedro Lobo <https://github.com/pslobo>"
LABEL Name="grok_exporter"
LABEL Version="0.2.5"

ENV GROK_ARCH="grok_exporter-0.2.5.linux-amd64"
ENV GROK_VERSION="0.2.5"

RUN apt-get update -qqy \
    && apt-get upgrade -qqy \
    && apt-get install --no-install-recommends -qqy \
       wget unzip ca-certificates \
    && update-ca-certificates \
    && wget https://github.com/fstab/grok_exporter/releases/download/$GROK_VERSION/$GROK_ARCH.zip \
    && unzip $GROK_VERSION.zip \
    && mv $GROK_VERSION /grok \
    && rm $GROK_VERSION.zip \
    && apt-get --autoremove purge -qqy \
       wget unzip ca-certificates \
    && rm -fr /var/lib/apt/lists/*

WORKDIR /grok

CMD ["./grok_exporter", "-config", "/grok/config.yml"]   
