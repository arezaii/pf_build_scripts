#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Usage: clone_pf_repo <directory> <repository> <branch>"
    exit 2
fi

DIR=$1
GIT_URL=$2
BRANCH=$3


if [ ! -d $DIR ]; then	 
	 mkdir -p $DIR
fi	
cd $DIR
git clone --single-branch --branch $BRANCH $GIT_URL parflow

