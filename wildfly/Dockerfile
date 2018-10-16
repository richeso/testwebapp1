FROM jboss/wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin1234 --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

##RUN  mkdir -p $JBOSS_HOME/modules/org/postgresql/main
##COPY postgresql-42.2.5.jar $JBOSS_HOME/modules/org/postgresql/main/
##COPY module.xml $JBOSS_HOME/modules/org/postgresql/main/
##COPY standalone.xml $JBOSS_HOME/standalone/configuration
##COPY webapps/testwebapp.war $JBOSS_HOME/standalone/deployments/testwebapp.war

##USER root
##RUN chmod -R 775 /tmp/scripts/*.sh
##RUN chmod -R 775 /opt/jboss/wildfly/standalone/deployments/
##RUN chown -R jboss:jboss /opt/jboss/wildfly/standalone/deployments/
##RUN chown -R jboss:jboss $JBOSS_HOME/modules/org/postgresql/
