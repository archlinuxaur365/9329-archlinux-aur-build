#!/usr/bin/env bash

set -x
# set -Eeu


export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"

cd $CMD_PATH

cd aur-all 
export n=1
for f in `ls`
do 
echo $n
    echo $f 
    cd ..
    git checkout $f 
    git merge dev 
    p2
    cd aur-all
done