#!/bin/bash

if [ ! -d "./wildfly/webapps" ]; then
   mkdir -p ./wildfly/webapps
fi

./buildwebapp.sh . testwebapp1 "/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.45.x86_64/"

