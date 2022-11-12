#!/usr/bin/env bash

set -x
# set -Eeu


export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"

cd $CMD_PATH
./12.workflow.stop "archlinuxaur365/9329-archlinux-aur-build"
cd 365
export n=1
git checkout dev
for f in `ls`
do 
echo $n
    echo $f 
    cd ..
    gh workflow enable $f.yml
    gh workflow run $f.yml
    cd aur-all
done