#!/bin/bash
set -e


mysqld_safe --user={{ .xbee.user }} 2>&1 >/dev/null &
sleep 1s

/usr/bin/expect <<EOF
spawn mysqladmin -u root password
expect {New password: } {send "{{ .password }}\n"}
expect {Confirm new password: } {send "{{ .password }}\n"}
expect eof
EOF

/usr/bin/expect <<EOF
spawn mysqladmin -p shutdown
expect {Enter password:} {send "{{ .password }}\n"}
expect eof
EOF