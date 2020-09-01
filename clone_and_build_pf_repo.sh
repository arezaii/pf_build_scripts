#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: clone_and_build_parflow <directory> <repository> <branch>"
    exit 2
fi


DIR=$1
REPO=$2
BRANCH=$3



./clone_pf_repo.sh $REPO $BRANCH $DIR

./rebuild_parflow.sh $DIR
