#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: clone_and_build_pf_repo <pf_libs directory> <parflow_directory> <repository> <branch>"
    exit 2
fi


clone_pf_repo() {
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
    cd -
}


build_parflow(){
    ./rebuild_parflow.sh $1 $2 
}

LIBSDIR=$1
PFDIR=$2
REPO=$3
BRANCH=$4


clone_pf_repo $PFDIR $REPO $BRANCH

build_parflow $LIBSDIR $PFDIR
