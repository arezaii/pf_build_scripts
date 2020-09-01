#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: clone_pf_repo <directory> <repository> <branch>"
    exit 2
fi

DIR=$1
GIT_URL=$2
BRANCH=$3


if [ ! -d $DIR ]; then	 
	 mkdir $DIR
fi	
cd $DIR
git clone --single-branch --branch $BRANCH $GIT_URL parflow
sed -e '376iset(CMAKE_C_FLAGS \"${CMAKE_C_FLAGS} -O2\")' -i parflow/CMakeLists.txt


