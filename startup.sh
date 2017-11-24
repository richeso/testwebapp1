#!/bin/bash

if [ ! -d "./wildfly/webapps" ]; then
   mkdir -p ./wildfly/webapps
fi

./buildwebapp.sh . testwebapp1 "/usr/lib/jvm/default-java"
docker volume create --name postgresdata -d local
docker-compose up -d
