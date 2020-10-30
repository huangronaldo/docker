#!/bin/sh
nginx -g "daemon off;"
#echo `ps -ef` > /tmp/keepalived.txt
#rm -rf /var/run/keepalived/keepalived.pid
/usr/sbin/keepalived -n -l -D -f /etc/keepalived/keepalived.conf --dont-fork --log-console &
