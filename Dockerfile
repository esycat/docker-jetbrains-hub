FROM esycat:alpine-openjre

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ENV APP_VERSION 2.5
ENV APP_BUILD 399

ENV APP_NAME hub
ENV APP_PORT 8080
ENV APP_UID 500

ENV APP_USER $APP_NAME
ENV APP_DISTNAME hub-ring-bundle-${APP_VERSION}.${APP_BUILD}
ENV APP_DISTFILE ${APP_DISTNAME}.zip
ENV APP_PREFIX /opt
ENV APP_DIR $APP_PREFIX/$APP_NAME
ENV APP_HOME /var/lib/$APP_NAME

# preparing home (data) directory and user+group
RUN mkdir $APP_HOME
RUN useradd --system --user-group --uid $APP_UID --home $APP_HOME $APP_USER
RUN chown -R $APP_USER:$APP_USER $APP_HOME

WORKDIR $APP_PREFIX

# downloading build dependencies,
# downloading and unpacking the distribution, changing file permissions, removing bundled JVMs,
# removing build dependencies
RUN apk add -q --no-cache --virtual .build-deps wget unzip && \
    wget -q https://download.jetbrains.com/hub/$APP_VERSION/$APP_DISTFILE && \
    unzip -q $APP_DISTFILE && \
    mv $APP_DISTNAME $APP_NAME && \
    chown -R $APP_USER:$APP_USER $APP_DIR && \
    rm -rf $APP_DIR/internal/java && \
    rm $APP_DISTFILE && \
    apk del .build-deps

USER $APP_USER
WORKDIR $APP_DIR

# configuring the application
RUN bin/hub.sh configure \
    --backups-dir $APP_HOME/backups \
    --data-dir    $APP_HOME/data \
    --logs-dir    $APP_HOME/log \
    --temp-dir    $APP_HOME/tmp \
    --listen-port $APP_PORT \
    --base-url    http://localhost/

ENTRYPOINT ["bin/hub.sh"]
CMD ["run"]
EXPOSE $APP_PORT
VOLUME ["$APP_HOME"]
