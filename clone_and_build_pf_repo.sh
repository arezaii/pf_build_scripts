#!/bin/bash

DIR=$1
REPO=$2
BRANCH=$3

./clone_pf_repo.sh $REPO $BRANCH $DIR

./rebuild_parflow.sh $DIR