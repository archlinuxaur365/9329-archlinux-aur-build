#!/usr/bin/env bash

set -x
# set -Eeu


export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"

cd $CMD_PATH
if [ ! -z $1 ];then
    ./12.workflow.stop.sh "archlinuxaur368/9329-archlinux-aur-build"
fi
cd 368
export n=1
git checkout dev
for f in `ls`
do 
echo $n
    echo $f 
    cd ..
    gh workflow enable $f.yml -R "archlinuxaur368/9329-archlinux-aur-build"
    gh workflow run $f.yml -R "archlinuxaur368/9329-archlinux-aur-build"
    cd 368
done