#!/usr/bin/env bash

set -x
# set -Eeu


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

rsync -avP ./ ~/9329/ > /dev/null
rsync -avzP README.md gnuhub@frs.sourceforge.net:/home/frs/project/archlinux365/9329-archlinux-aur-build/x86_64/  > /dev/null




chown -R runner:runner ~/9329/
cd ~/9329/
ls -al 

buildaur(){
    sudo -u runner git clone --depth=1 -b $1 "https://github.com/archlinux/aur.git" "tmp_${1}"
    cd "tmp_${1}"
    sudo -u runner makepkg -s --nosign --noconfirm -f > ${1}.$GITHUB_RUN_NUMBER.log.txt
    rsync -avzP *.zst gnuhub@frs.sourceforge.net:/home/frs/project/archlinux365/9329-archlinux-aur-build/x86_64/
    rsync -avzP *.log.txt gnuhub@frs.sourceforge.net:/home/frs/project/archlinux365/9329-archlinux-aur-build/x86_64_log/
    cd ..
    rm -rf "tmp_${1}"
}

cd aur-all/$1

for pkg in `ls`
do
    buildaur $pkg
done
