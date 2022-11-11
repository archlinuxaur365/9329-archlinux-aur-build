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
    cp -fv ./9.autobuild.yml .github/workflows/$f.yml 
    sed -i "s/branch_name/$f/g" .github/workflows/$f.yml
    sed -i "s/schedule_num/$n/g" .github/workflows/$f.yml
    n=$(($n+1))
    if [ $n -gt 23 ];then
        n=1
    fi
    cd aur-all
done