FROM node:12.16-alpine

COPY . /app

WORKDIR /app

RUN npm config set registry http://npm.shiduai.com/ \
    && npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/ \
    && npm config set canvas_binary_host_mirror https://npm.taobao.org/mirrors/node-canvas-prebuilt/ \
    && npm config set ENTRYCLI_CDNURL https://cdn.npm.taobao.org/dist/sentry-cli \
    && npm config set sentrycli_cdnurl https://cdn.npm.taobao.org/dist/sentry-cli \
    && apk upgrade --update \
    && apk add bash git ca-certificates \
    && npm install -g bower \
    && npm --unsafe-perm --production install \
    && apk del git \
    && rm -rf /var/cache/apk/* \
    /app/.git \
    /app/screenshots \
    /app/test \
    && adduser -H -S -g "Konga service owner" -D -u 1200 -s /sbin/nologin konga \
    && mkdir /app/kongadata /app/.tmp \
    && chown -R 1200:1200 /app/views /app/kongadata /app/.tmp

EXPOSE 1337

VOLUME /app/kongadata

ENTRYPOINT ["/app/start.sh"]
