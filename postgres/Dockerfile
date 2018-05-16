# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>
# Modified to run on RHEL and to add SSL Connection by Shah Zobair

FROM registry.access.redhat.com/rhel7
MAINTAINER Shah Zobair <szobair@redhat.com>

RUN cat /etc/resolv.conf
RUN groupadd postgres -g 1001 && \
    useradd postgres -u 1001 -g 1001

RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum --disablerepo='*' --enablerepo=epel --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms --enablerepo=rhel-7-server-optional-rpms install -y hostname net-tools postgresql-server postgresql postgresql-contrib supervisor pwgen && yum clean all

ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

RUN chmod +x /usr/bin/postgresql-setup
RUN chmod 777 /start_postgres.sh

RUN /usr/bin/postgresql-setup initdb && \
    mkdir /BACKUP && \
    cp -pr /var/lib/pgsql/* /BACKUP/

ADD ./postgresql.conf /postgresql.conf
ADD db_entry.sh /db_entry.sh
ADD CERT/server.key /server.key
ADD CERT/server.crt /server.crt
ADD CERT/root.crt /root.crt

RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf /db_entry.sh /server.key /server.crt /root.crt

#VOLUME ["/var/lib/pgsql"]

EXPOSE 5432
USER postgres

CMD ["/bin/bash", "/start_postgres.sh"]
