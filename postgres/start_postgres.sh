#!/bin/bash

PG_CONFDIR="/var/lib/pgsql/data"


__start_postgres() {


SYS_UID=`id -u`
SYS_GID=`id -g`
sed -i s/1001/$SYS_UID/g /etc/passwd
sed -i s/1001/$SYS_GID/g /etc/group

if [ ! -d "/var/lib/pgsql/data" ]; then
    mkdir /var/lib/pgsql/data
    chmod 700 /var/lib/pgsql/data
    touch /var/lib/pgsql/data/a
    cp -r /BACKUP/data/* /var/lib/pgsql/data
    cp /BACKUP/initdb.log /var/lib/pgsql/
    cp -r /BACKUP/backups /var/lib/pgsql/
fi

cp /postgresql.conf /var/lib/pgsql/data/postgresql.conf
cp /root.crt /var/lib/pgsql/data/root.crt
cp /server.crt /var/lib/pgsql/data/server.crt
cp /server.key /var/lib/pgsql/data/server.key
chmod 600 /var/lib/pgsql/data/server.key 

#echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf
#echo "hostssl all         postgres    0.0.0.0/0             md5 clientcert=1" >> /var/lib/pgsql/data/pg_hba.conf
echo "hostssl all         shah    0.0.0.0/0             md5 clientcert=1" >> /var/lib/pgsql/data/pg_hba.conf

/usr/bin/pg_ctl -D /var/lib/pgsql/data -l /tmp/logfile start

echo "CREATE DATABASE testing;" | psql
echo "CREATE TABLE dummy (name varchar(50), id int);" | psql testing
echo "INSERT INTO dummy (name, id) values ('shah',1);" | psql testing
echo "SELECT * FROM dummy;" | psql testing

echo "CREATE ROLE shah with CREATEROLE login superuser PASSWORD 'shah123';" | psql testing
echo "GRANT ALL PRIVILEGES ON DATABASE testing to shah;" | psql testing

/usr/bin/pg_ctl -D /var/lib/pgsql/data -l /tmp/logfile stop

postgres --single -c config_file=${PG_CONFDIR}/postgresql.conf -D ${PG_CONFDIR}

}

__run_supervisor() {
supervisord -n
}


__add_db_entry() {

echo "CREATE DATABASE testing;" | psql
echo "CREATE TABLE dummy (name varchar(50), id int);" | psql testing
echo "INSERT INTO dummy (name, id) values ('shah',1);" | psql testing
echo "SELECT * FROM dummy;" | psql testing

echo "CREATE ROLE shah with CREATEROLE login superuser PASSWORD 'shah123';" | psql testing
echo "GRANT ALL PRIVILEGES ON DATABASE testing to shah;" | psql testing

}

# Call all functions
__start_postgres
#__add_db_entry
__run_supervisor
