#!/bin/bash

GIT_URL=$1
BRANCH=$2
DIR=$3

	if [ ! -d $DIR ]; then	 
	 mkdir $DIR
	fi	
cd $DIR
git clone --single-branch --branch $BRANCH $GIT_URL parflow
sed -e '376iset(CMAKE_C_FLAGS \"${CMAKE_C_FLAGS} -O2\")' -i parflow/CMakeLists.txt


