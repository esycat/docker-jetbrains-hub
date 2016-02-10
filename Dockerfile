FROM java:latest

MAINTAINER Seti <seti@setadesign.net>

ENV APP_VERSION 1.0
ENV APP_BUILD $APP_VERSION.797
ENV APP_HOME /data


RUN curl -L https://download.jetbrains.com/hub/$APP_VERSION/hub-ring-bundle-$APP_BUILD.zip -o /opt/hub.zip && \
	mkdir /opt/hub -p && cd /opt/hub/ && \
	unzip /opt/hub.zip && \
	rm -f /opt/hub.zip && \
	rm -rf /opt/hub/internal/java && \
	mkdir $APP_HOME && \
	groupadd -r hub && \
	useradd -r -g hub -u 1000 -d $APP_HOME hub && \
	chown -R hub:hub $APP_HOME /opt/hub

WORKDIR /opt/hub
ADD run.sh /opt/hub/
RUN chmod o+rx run.sh
USER hub
ENTRYPOINT ["/opt/hub/run.sh"]
EXPOSE 8080
VOLUME ["$APP_HOME"]
