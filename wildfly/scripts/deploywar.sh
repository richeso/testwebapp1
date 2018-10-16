#!/bin/bash

JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

echo "SCRIPT running under userid:" 
echo `whoami`
server=mywildfly
user="jboss"

docker exec -i $server bash <<EOF
echo "==> Executing..."
$JBOSS_CLI -c --file=/tmp/wildfly/scripts/batch.cli  --connect
$JBOSS_CLI --connect --command="deploy --force /tmp/wildfly/webapps/testwebapp.war"

##Undeploying an application works adequately:
##$JBOSS_CLI  --connect --command="undeploy testwebapp.war"

EOF
