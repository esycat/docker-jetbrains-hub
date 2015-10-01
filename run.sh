#!/bin/sh

if [ ! -e $APP_HOME/conf ];
then
	echo "first run: starting configure"
	mv /opt/hub/conf $APP_HOME/
	ln -s $APP_HOME/conf /opt/hub/conf
	bin/hub.sh configure \
		--backups-dir $APP_HOME/backups \
		--data-dir    $APP_HOME/data \
		--logs-dir    $APP_HOME/log \
		--temp-dir    $APP_HOME/tmp \
		--listen-port 8080 \
		--base-url    http://$BASE_URL/
else
	rm -rf /opt/hub/conf
	ln -s $APP_HOME/conf /opt/hub/conf
fi

bin/hub.sh run
