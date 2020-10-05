#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: clone_and_build_pf_repo <pf_libs directory> <parflow_directory> <repository> <branch>"
    exit 2
fi

LIBSDIR=$1
PFDIR=$2
REPO=$3
BRANCH=$4



./clone_pf_repo.sh $PFDIR $REPO $BRANCH 

./build_parflow.sh $LIBSDIR $PFDIR 
