#!/bin/bash

if [ ! -d "./wildfly/webapps" ]; then
   mkdir -p ./wildfly/webapps
fi

./buildwebapp.sh . testwebapp1 "/c/pg/java/jdk1.7.0_80"
docker volume create --name postgresdata -d local
docker-compose up -d
