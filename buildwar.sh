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


javaunix="/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.45.x86_64/"
javawindows="/c/pg/java/jdk1.7.0_80"
javadefault=$javaunix

if [ "$(uname)" == "Darwin" ]; then
    javadefault=$javaunix
    echo ">>> Running Under MAC OSX java: "$javadefault 
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    javadefault=$javaunix
    echo ">>> Running under Linux Platform java: "$javadefault
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
     javadefault=$javawindows
    echo ">>> Running under Windows -  MINGw32: "$javadefault
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    javadefault=$javawindows
    echo ">>> Running under WIndows - MINGW64: "$javadefault
fi

srcscript="${BASH_SOURCE[0]}"
basedir=$(get_script_dir)
echo ">>> basedir of invocation script: $srcscript is $basedir "

cd $basedir
./buildwebapp.sh . testwebapp1 $javadefault



