#!/usr/bin/env bash

set -x
# set -Eeu


export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"

cd $CMD_PATH

git remote add archlinuxaur366 git@github.com:archlinuxaur366/9329-archlinux-aur-build.git
git remote add archlinuxaur367 git@github.com:archlinuxaur367/9329-archlinux-aur-build.git
git remote add archlinuxaur368 git@github.com:archlinuxaur368/9329-archlinux-aur-build.git
cd aur-all 
export n=1
git checkout dev
for f in `ls`
do 
echo $n
    echo $f 
    cd ..
    git checkout -b $f 
    git checkout $f 
    git merge dev 

    p2
    git push archlinuxaur366 $f
    git push archlinuxaur367 $f
    git push archlinuxaur368 $f
    cd aur-all
done