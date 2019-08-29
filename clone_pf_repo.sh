#!/bin/bash

GIT_URL=$1
BRANCH=$2
DIR=$3

	if [ ! -d $DIR ]; then	 
	 mkdir $DIR
	fi	
cd $DIR
git clone --single-branch --branch $BRANCH $GIT_URL parflow

