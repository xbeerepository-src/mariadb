#!/bin/bash
set -e


mysqld_safe --user={{ .pack.xbeeUser }} 2>&1 >/dev/null &
sleep 1s

/usr/bin/expect <<EOF
spawn mysqladmin -u root password
expect {New password:} {send "{{ .pack.password }}\n"}
expect {Confirm new password:} {send "{{ .pack.password }}\n"}
expect eof
EOF

/usr/bin/expect <<EOF
spawn mysqladmin -p shutdown
expect {Enter password:} {send "{{ .pack.password }}\n"}
expect eof
EOF