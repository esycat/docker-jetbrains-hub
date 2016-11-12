FROM esycat/java:oracle-8

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ENV APP_VERSION=2.5 \
    APP_BUILD=399 \
    APP_PORT=8080 \
    APP_USER=hub \
    APP_SUFFIX=hub \
    APP_PREFIX=/opt

ENV APP_DISTNAME=hub-ring-bundle-${APP_VERSION}.${APP_BUILD} \
    APP_DIR=$APP_PREFIX/${APP_SUFFIX} \
    APP_HOME=/var/lib/${APP_SUFFIX}

ENV APP_DISTFILE=${APP_DISTNAME}.zip

# preparing home (data) directory and user+group
RUN useradd -r -U -d $APP_HOME $APP_USER && \
    mkdir $APP_HOME && \
    chown -R $APP_USER:$APP_USER $APP_HOME

# downloading and unpacking the distribution, removing bundled JVMs
WORKDIR $APP_PREFIX
RUN wget -q https://download.jetbrains.com/hub/$APP_VERSION/$APP_DISTFILE && \
    unzip -q $APP_DISTFILE && \
    mv $APP_DISTNAME $APP_SUFFIX && \
    chown -R $APP_USER:$APP_USER $APP_DIR && \
    rm -rf $APP_DIR/internal/java && \
    rm $APP_DISTFILE

USER $APP_USER
WORKDIR $APP_DIR

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
