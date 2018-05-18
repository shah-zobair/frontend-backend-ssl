FROM registry.access.redhat.com/rhel7
#FROM openshift/rhel7


RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
    yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms install -y httpd mod_rewrite php php-bcmath php-cli php-common php-devel php-mysql php-odbc php-pdo  php-pspell php-pgsql php-ldap php-mbstring php-gd mod_ssl && yum clean all

RUN useradd 1001 \
 && chown -R 1001:1001 /var/log/httpd \
 && chown -R 1001:1001 /etc/httpd \
 && chmod -R 777 /var/run/httpd \
 && chmod -R 777 /var/log/httpd \
 && chmod -R 777 /etc/httpd \
 && chmod -R 777 /etc/pki

RUN sed -i 's/User apache/User 1001/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Group apache/Group 1001/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Listen 443/Listen 8443/g' /etc/httpd/conf.d/ssl.conf \
 && sed -i 's/VirtualHost _default_:443/VirtualHost _default_:8443/g' /etc/httpd/conf.d/ssl.conf

RUN ln -sf /dev/stdout /etc/httpd/logs/access_log \
 && ln -sf /dev/stderr /etc/httpd/logs/error_log

COPY CERT /tmp/
COPY CERT/frontend.cert /etc/pki/tls/certs/
#ADD CERT/postgresql.key /tmp/postgresql.key
#ADD CERT/postgresql.crt /tmp/postgresql.crt
#ADD CERT/root.crt /tmp/root.crt
ADD run.sh /tmp/run.sh
RUN chown -v 1001:1001 /tmp/postgresql.key /tmp/postgresql.crt /tmp/root.crt /tmp/frontend.cert && \
    chmod 666 /tmp/postgresql.key /tmp/frontend.key && \
    chmod 777 /tmp/run.sh


USER 1001
#RUN cat /tmp/postgresql.key > /tmp/postgresql-user.key && \
#    chmod 600 /tmp/postgresql-user.key

EXPOSE 8080 8443

COPY index.html /var/www/html/
COPY db-ssl.php /var/www/html/

#CMD ["httpd", "-D", "FOREGROUND"]
CMD ["/tmp/run.sh"]
