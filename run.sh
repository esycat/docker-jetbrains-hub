#!/bin/sh

if [ ! -e $APP_HOME/conf ];
then
	echo "first run: starting configure"
	ln -s $APP_DIR/conf $APP_HOME/conf
	bin/hub.sh configure \
		--backups-dir $APP_HOME/backups \
		--data-dir    $APP_HOME/data \
		--logs-dir    $APP_HOME/log \
		--temp-dir    $APP_HOME/tmp \
		--listen-port $APP_PORT \
		--base-url    http://localhost/
fi

bin/hub.sh run