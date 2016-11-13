FROM FROM openjdk:jre-alpine

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ARG APP_PREFIX=/srv
ARG APP_PORT=8080
ARG APP_HOME_PREFIX=/var/lib
ARG APP_USER=hub

ENV APP_VERSION=2.5 \
    APP_BUILD=399 \
    APP_NAME=hub \
    USER_UID=999 \
    APP_SOURCE_TYPE=zip

ENV APP_DIR=${APP_PREFIX}/${APP_NAME} \
    APP_HOME=${APP_HOME_PREFIX}/${APP_NAME} \
    APP_DISTNAME=hub-ring-bundle-${APP_VERSION}.${APP_BUILD}

ENV APP_DISTFILE=${APP_DISTNAME}.${APP_SOURCE_TYPE}

EXPOSE ${APP_PORT}
VOLUME ["${APP_HOME}"]
WORKDIR ${APP_PREFIX}

RUN apk -q --no-cache add --virtual .build-deps curl ca-certificates libarchive-tools&& \
    mkdir ${APP_NAME} && \
    delgroup ping && \
    addgroup ${APP_USER} -g ${USER_UID} && \
    adduser -S -u ${USER_UID} -H -D -G ${APP_USER} ${APP_USER} && \
    chown -R ${APP_USER}:${APP_USER} ${APP_HOME} && \

    # downloading and unpacking the distribution, changing file permissions, removing bundled JVMs,
    # removing downloads

    curl -sSL -o ${APP_DISTFILE} https://download.jetbrains.com/hub/${APP_VERSION}/${APP_DISTFILE} && \
    bsdtar -xf ${APP_DISTFILE} --uname ${APP_USER} --gname ${APP_USER} --exclude */internal/java/* -s'|[^/]*/||' -C ${APP_DIR} && \
    apk -q del .build-deps && \
    rm ${APP_DISTFILE} && \

# configuring the application
    ${APP_DIR}/bin/hub.sh configure \
    --backups-dir ${APP_HOME}/backups \
    --data-dir    ${APP_HOME}/data \
    --logs-dir    ${APP_HOME}/log \
    --temp-dir    ${APP_HOME}/tmp \
    --listen-port ${APP_PORT} \
    --base-url    http://localhost/

USER ${APP_USER}
ENTRYPOINT ["hub/bin/hub.sh"]
CMD ["run"]
