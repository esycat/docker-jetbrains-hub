FROM java:latest

MAINTAINER Seti <seti@setadesign.net>

ENV APP_VERSION 1.0
ENV APP_BUILD ${APP_VERSION}.583
ENV APP_PORT 8080
ENV APP_USER hub
ENV APP_SUFFIX hub

ENV APP_DISTFILE hub-ring-bundle-${APP_BUILD}.zip
ENV APP_PREFIX /opt
ENV APP_DIR $APP_PREFIX/$APP_SUFFIX
ENV APP_HOME /var/lib/$APP_SUFFIX

# downloading and unpacking the distribution
RUN curl -L https://download.jetbrains.com/hub/$APP_VERSION/$APP_DISTFILE -o $APP_PREFIX/$APP_DISTFILE \
	unzip $APP_DISTFILE -d $APP_DIR \
	rm -f $APP_DISTFILE \
	rm -rf $APP_DIR/internal/java \
	mkdir $APP_HOME \
	groupadd -r $APP_USER \
	useradd -r -g $APP_USER -u 1000 -d $APP_HOME $APP_USER \
	chown -R $APP_USER:$APP_USER $APP_HOME $APP_DIR

WORKDIR $APP_DIR
ADD run.sh
RUN chmod o+rx run.sh
USER $APP_USER
ENTRYPOINT ["run.sh"]
EXPOSE $APP_PORT
VOLUME ["$APP_HOME"]
