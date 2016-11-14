FROM FROM openjdk:jre-alpine

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ARG APP_PREFIX=/srv
ARG APP_PORT=8080
ARG APP_HOME_PREFIX=/var/lib
ARG APP_USER=hub
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION

ENV APP_VERSION=2.5 \
    APP_BUILD=399 \
    APP_NAME=hub \
    USER_UID=1000 \
    APP_SOURCE_TYPE=zip

ENV APP_DIR=${APP_PREFIX}/${APP_NAME} \
    APP_HOME=${APP_HOME_PREFIX}/${APP_NAME} \
    APP_DISTNAME=hub-ring-bundle-${APP_VERSION}.${APP_BUILD}

ENV APP_DISTFILE=${APP_DISTNAME}.${APP_SOURCE_TYPE}

EXPOSE ${APP_PORT}
VOLUME ["${APP_HOME}"]

RUN apk -q --no-cache add --virtual .build-deps curl ca-certificates libarchive-tools&& \
    addgroup ${APP_USER} -g ${USER_UID} && \
    adduser -S -u ${USER_UID} -h ${APP_DIR} -D -G ${APP_USER} ${APP_USER} && \
    curl -sSL -o ${APP_DISTFILE} https://download.jetbrains.com/hub/${APP_VERSION}/${APP_DISTFILE} && \
    bsdtar -xf ${APP_DISTFILE} --uname ${APP_USER} --gname ${APP_USER} --exclude */internal/java/* -s'|[^/]*/||' -C ${APP_DIR} && \
    apk -q del .build-deps && \
    rm ${APP_DISTFILE} && \
    chown -R ${APP_USER}.${APP_USER} ${APP_HOME} && \
    
    ${APP_DIR}/bin/hub.sh configure \
    --backups-dir ${APP_HOME}/backups \
    --data-dir    ${APP_HOME}/data \
    --logs-dir    ${APP_HOME}/log \
    --temp-dir    ${APP_HOME}/tmp \
    --listen-port ${APP_PORT} \
    --base-url    http://localhost/

USER ${APP_USER}
WORKDIR ${APP_DIR}
ENTRYPOINT ["bin/hub.sh"]
CMD ["run"]
