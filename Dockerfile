FROM java:latest

MAINTAINER "Seti" <seti@setadesign.net>

ENV APP_VERSION 2017.2
ENV APP_BUILD $APP_VERSION.5845
ENV APP_HOME /data


RUN curl -k -L https://download.jetbrains.com/hub/$APP_VERSION/hub-ring-bundle-$APP_BUILD.zip -o /opt/hub.zip && \
	cd /opt && \
	unzip /opt/hub.zip && \
	mv hub-ring-bundle-$APP_BUILD hub && \
	rm -f /opt/hub.zip && \
	rm -rf /opt/hub/internal/java && \
	mkdir $APP_HOME && \
	groupadd -r hub && \
	useradd -r -g hub -u 1000 -d $APP_HOME hub && \
	chown -R hub:hub $APP_HOME /opt/hub && \
	mv /opt/hub/conf /opt/hub/conftemplate

WORKDIR /opt/hub
ADD run.sh /opt/hub/
RUN chmod o+rx run.sh
USER hub
ENTRYPOINT ["/opt/hub/run.sh"]
EXPOSE 8080
VOLUME ["$APP_HOME"]
