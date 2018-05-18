#!/bin/bash

cat /tmp/postgresql.key > /tmp/postgresql-user.key
chmod 600 /tmp/postgresql-user.key

httpd -D FOREGROUND
