#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: clone_and_build_pf_repo <directory> <repository> <branch>"
    exit 2
fi


DIR=$1
REPO=$2
BRANCH=$3



./clone_pf_repo.sh $DIR $REPO $BRANCH 

./rebuild_parflow.sh $DIR
