FROM esycat/java:oracle-8

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ENV APP_VERSION 1.0
ENV APP_BUILD ${APP_VERSION}.529
ENV APP_PORT 8080
ENV APP_USER hub
ENV APP_SUFFIX hub

ENV APP_DISTFILE hub-ring-bundle-${APP_BUILD}.zip
ENV APP_PREFIX /opt
ENV APP_DIR $APP_PREFIX/$APP_SUFFIX
ENV APP_HOME /var/lib/$APP_SUFFIX

# downloading and unpacking the distribution
WORKDIR $APP_PREFIX
ADD https://download.jetbrains.com/hub/$APP_VERSION/$APP_DISTFILE $APP_PREFIX/
# COPY $APP_DISTFILE $APP_PREFIX/
RUN unzip $APP_DISTFILE -d $APP_DIR
RUN rm $APP_DISTFILE

# removing bundled JVMs
RUN rm -rf $APP_DIR/internal/java

# preparing home (data) directory and user+group
RUN mkdir $APP_HOME
RUN groupadd -r $APP_USER
RUN useradd -r -g $APP_USER -d $APP_HOME $APP_USER
RUN chown -R $APP_USER:$APP_USER $APP_HOME $APP_DIR

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
