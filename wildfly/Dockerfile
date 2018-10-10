FROM jboss/wildfly:8.1.0.Final
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin1234 --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

RUN  mkdir -p $JBOSS_HOME/modules/org/postgres/main
COPY postgresql-9.4.1212.jar $JBOSS_HOME/modules/org/postgres/main/
COPY module.xml $JBOSS_HOME/modules/org/postgres/main/
COPY standalone.xml $JBOSS_HOME/standalone/configuration
COPY webapps/testwebapp.war $JBOSS_HOME/standalone/deployments/testwebapp.war


