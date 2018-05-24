FROM registry.access.redhat.com/jboss-webserver-3/webserver31-tomcat7-openshift

RUN mkdir -p /home/jboss/.postgresql && \
    chmod 777 /home/jboss/.postgresql

COPY bundle.pem bundle.pem
COPY bundle.pem /home/jboss/.postgresql/bundle.pem
COPY mykeystore.jks $JAVA_HOME/jre/lib/security/pgkey.jks

RUN id
USER root
RUN id

RUN cp bundle.pem /etc/pki/ca-trust/source/anchors/ && \
    update-ca-trust extract
    
RUN rm -rf $JWS_HOME/lib/mongo.jar && rm -rf $JWS_HOME/lib/mysql-connector-java.jar

COPY icps.war $JWS_HOME/webapps/app#scr#icps#api.war
