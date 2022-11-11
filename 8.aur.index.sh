#!/usr/bin/env bash

set -x
# set -Eeu


export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"

cd $CMD_PATH

sed -i "/\* main/d" 7.aur.all.txt
sed -i "s/  remotes\/origin\///g" 7.aur.all.txt

mkdir -p aur-all
while read line
do
    echo $line
    index=${line:0:1}
    mkdir -p aur-all/$index 
    touch aur-all/$index/$line
done < 7.aur.all.txt