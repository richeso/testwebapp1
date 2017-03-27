#!/bin/bash

echo "SCRIPT running under userid:" 
echo `whoami`
echo "CURRENT ANT_HOME="$ANT_HOME
echo "CURRENT PATH="$PATH


checkrc() {
 
       echo "------------------------------"
  echo "$1 return code = " $rc  
 echo "------------------------------"
  echo " "
       if [ $rc -gt 0 ]; then
          echo "----> $STEP FAILED with return Code: $rc"
          exit 1 
        else
           echo " --> $STEP successful: $rc"   
        fi
}
  

# Check number of arguments passed into script 

EXPECTED_ARGS=3
E_BADARGS=12

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` rootdir project"
  exit $E_BADARGS
fi

rootdir=$1
project=$2
JDK_PATH=$3

curpath=$(pwd)
echo "rootdir is:" $rootdir
echo "current path is: " $curpath
echo "JDK_PATH is: " $JDK_PATH

cd $rootdir
echo "updating source from git repository into directory: "$rootdir/$project
echo `git clean -df`
echo `git checkout -- .`
echo `git pull`
cd $curpath

if [ ! -d "./wildfly/webapps" ]; then
   mkdir -p ./wildfly/webapps
fi
chmod 775 -R *
ant -f replace_localhost.xml -Ddbhost=mypostgres -Dwebhost=mycentos1 -Dwebport=8080
cd $rootdir/$project/
gradle -Dorg.gradle.java.home=$JDK_PATH build war
cd $curpath
cp ./testwebapp1/build/libs/testwebapp.war ./wildfly/webapps/testwebapp.war
