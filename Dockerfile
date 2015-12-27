FROM busybox:ubuntu-14.04
MAINTAINER Albert Dixon <albert.dixon@schange.com>

ENTRYPOINT ["docker-entry"]
CMD ["docker-start"]
EXPOSE 4040

ENV COUCHPOTATO_ENABLED yes
ENV COUCHPOTATO_PORT 5050
ENV SICKRAGE_ENABLED yes
ENV SICKRAGE_PORT 8081
ENV PLEX_ENABLED yes
ENV PLEX_PORT 32400

ENV TLS           both
ENV LOG_LEVEL     info
ENV LOG_FMT       logfmt
ENV COMPRESS_CONN false

ADD configs /templates/
ADD scripts/* /usr/local/bin/
RUN chmod a+rx /usr/local/bin/*

ADD https://github.com/albertrdixon/tmplnator/releases/download/v2.2.1/t2-linux.tgz /t2.tgz
RUN tar xvzf /t2.tgz -C /usr/local/bin

ENV NGROK_VER 2.0.19
ADD https://dl.ngrok.com/ngrok_${NGROK_VER}_linux_amd64.zip /ng.zip
RUN unzip -d /bin /ng.zip \
    && rm -f /ng.zip
