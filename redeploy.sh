#!/bin/bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}


if [ "$(uname)" == "Darwin" ]; then
    echo ">>> Running Under MAC OSX : "
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo ">>> Running under Linux Platform : "
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
    echo ">>> Running under Windows -  MINGw32: "
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then 
    echo ">>> Running under WIndows - MINGW64: "
fi

srcscript="${BASH_SOURCE[0]}"
basedir=$(get_script_dir)
echo ">>> basedir of invocation script: $srcscript is $basedir "

if [ ! -d "./wildfly/webapps" ]; then
   mkdir -p ./wildfly/webapps
fi

cd $basedir
docker stop mywildfly
docker stop mypostgres
docker rm mywildfly
docker rm mypostgres
docker rmi testwebapp1_web
docker rmi testwebapp1_db
docker volume remove postgresdata
docker volume create --name postgresdata -d local
docker-compose up -d
