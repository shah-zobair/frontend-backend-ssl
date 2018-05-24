FROM registry.access.redhat.com/jboss-webserver-3/webserver31-tomcat7-openshift

RUN mkdir -p /home/jboss/.postgresql && \
    chmod 777 /home/jboss/.postgresql

COPY ca-cert.pem ca-cert.pem
COPY ca.crt /home/jboss/.postgresql/root.crt
COPY mykeystore.jks $JAVA_HOME/jre/lib/security/pgkey.jks

RUN id

USER root

RUN cp ca-cert.pem /etc/pki/ca-trust/source/anchors/ && \
    cp /home/jboss/.postgresql/root.crt /etc/pki/ca-trust/source/anchors/ && \
    update-ca-trust extract
    
RUN rm -rf $JWS_HOME/lib/mongo.jar && rm -rf $JWS_HOME/lib/mysql-connector-java.jar

COPY icps.war $JWS_HOME/webapps/app#scr#icps#api.war
