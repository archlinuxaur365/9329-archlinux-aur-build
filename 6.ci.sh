#!/usr/bin/env bash

set -x
set -Eeu


export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"

cd $CMD_PATH
env
pwd
whoami
df -h
free -m
cp -fv known_hosts /root/.ssh/known_hosts
ssh-keygen -f "/root/.ssh/known_hosts" -R "frs.sourceforge.net"
ssh-keyscan "frs.sourceforge.net" >> /root/.ssh/known_hosts
cat /root/.ssh/known_hosts

rsync -avP ./ ~/9329/
chown -R runner:runner ~/9329/
cd ~/9329/
ls -al 

buildaur(){
    sudo -u runner git clone --depth=1 -b $1 "https://github.com/archlinux/aur.git" "${1}"
    cd "${1}"
    sudo -u runner makepkg --ignorearch --clean --cleanbuild --force --skippgpcheck --noconfirm --syncdeps
    cd ..
    rm -rf "${1}"
}

cd hourly

for pkg in `ls`
do
    buildaur $pkg
done
