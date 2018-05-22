#!/bin/bash

cat /tmp/postgresql.key > /tmp/postgresql-user.key
chmod 600 /tmp/postgresql-user.key

cat /tmp/frontend.key > /etc/pki/tls/private/frontend.key
chmod 600 /etc/pki/tls/private/frontend.key

httpd -D FOREGROUND
