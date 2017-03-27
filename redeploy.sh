#!/bin/bash

if [ ! -d "./wildfly/webapps" ]; then
   mkdir -p ./wildfly/webapps
fi

docker stop mywildfly
docker stop mypostgres
docker rm mywildfly
docker rm mypostgres
docker rmi testwebapp1_web
docker rmi testwebapp1_db
docker volume remove postgresdata
docker volume create --name postgresdata -d local
docker-compose up -d
