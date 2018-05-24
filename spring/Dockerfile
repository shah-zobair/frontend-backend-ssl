FROM registry.access.redhat.com/jboss-webserver-3/webserver31-tomcat7-openshift

RUN mkdir -p /home/jboss/.postgresql && \
    chmod 777 /home/jboss/.postgresql

COPY bundle.pem bundle.pem
COPY bundle.pem /home/jboss/.postgresql/bundle.pem
COPY mykeystore.jks $JAVA_HOME/jre/lib/security/pgkey.jks

RUN id
USER root
RUN id

RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
    yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms install -y php php-bcmath php-cli php-common php-devel php-mysql php-odbc php-pdo php-pspell php-pgsql php-ldap php-mbstring php-gd mod_ssl openssl && yum clean all
    
RUN cp bundle.pem /etc/pki/ca-trust/source/anchors/ && \
    update-ca-trust enable && \
    update-ca-trust extract
    
RUN rm -rf $JWS_HOME/lib/mongo.jar && rm -rf $JWS_HOME/lib/mysql-connector-java.jar

COPY icps.war $JWS_HOME/webapps/app#scr#icps#api.war
