FROM v2fly/v2fly-core

LABEL maintainer="KingFalse@yzsl@live.com"

USER 0
ENV DOMAIN=your.domain.com
ENV PORT=443
WORKDIR /srv

ADD ./config/v2-server.json /srv/
ADD ./config/v2-client.json /srv/
ADD ./v2-server.sh /srv/

RUN set -eux; \
    apk add --no-cache ca-certificates mailcap; \
    chmod +x v2-server.sh

CMD ["sh","/srv/v2-server.sh"]