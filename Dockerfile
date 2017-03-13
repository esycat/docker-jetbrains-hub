FROM esycat/java:alpine-openjre

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ARG APP_VERSION=2017.1
ARG APP_BUILD=4524

LABEL \
    version="${APP_VERSION}.${APP_BUILD}" \
    com.esyfur.jetbrains-hub-version="${APP_VERSION}.${APP_BUILD}" \
    com.esyfur.vcs-url="https://github.com/esycat/docker-jetbrains-hub"

ENV APP_NAME=hub \
    APP_PORT=8080 \
    APP_UID=500 \
    APP_PREFIX=/srv \
    APP_DISTNAME="hub-ring-bundle-${APP_VERSION}.${APP_BUILD}"

ENV APP_USER=$APP_NAME \
    APP_DIR=$APP_PREFIX/$APP_NAME \
    APP_HOME=/var/lib/$APP_NAME \
    APP_DISTFILE="${APP_DISTNAME}.zip"

# preparing home (data) directory and user+group
RUN adduser -S -u $APP_UID -H -D $APP_USER && \
    mkdir $APP_HOME && \
    chown -R $APP_USER $APP_HOME && \

# downloading and unpacking the distribution, changing file permissions, removing bundled JVMs,
# removing downloads

    wget -q http://download.jetbrains.com/hub/$APP_VERSION/$APP_DISTFILE && \
    unzip -q $APP_DISTFILE -x */internal/java/* -d $APP_PREFIX && \
    mv $APP_PREFIX/$APP_DISTNAME/ $APP_DIR/ && \
    chown -R $APP_USER $APP_DIR && \
    rm $APP_DISTFILE && \

# configuring the application
    $APP_DIR/bin/hub.sh configure \
    --backups-dir $APP_HOME/backups \
    --data-dir    $APP_HOME/data \
    --logs-dir    $APP_HOME/log \
    --temp-dir    $APP_HOME/tmp \
    --listen-port $APP_PORT \
    --base-url    http://localhost/

WORKDIR $APP_DIR
ENTRYPOINT ["bin/hub.sh"]
CMD ["run"]
EXPOSE $APP_PORT
VOLUME ["$APP_HOME"]
