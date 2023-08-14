#!/bin/bash
set -e

mysql_install_db --basedir=/usr --datadir={{ .datadir }} --user={{ .xbee.user }} && chown -R {{ .xbee.user }}:{{ .xbee.group }} {{ .datadir }}
install -v -m755 -o {{ .xbee.user }} -g {{ .xbee.group }} -d /run/mysqld


mysqld_safe --user={{ .xbee.user }} 2>&1 >/dev/null &
sleep 1s

/usr/bin/expect <<EOF
spawn mysqladmin -u root password
expect {New password: } {send "{{ .password }}\n"}
expect {Confirm new password: } {send "{{ .password }}\n"}
expect eof
EOF
