#!/bin/bash

USED_BRANCH='bootstrap'


if  [[ -f /.bootstraped ]]; then
    exit 0;
else
    touch /.bootstraped ;
fi


WHOAMI="$(whoami)";
REPO_PREFIX="/etc/custom";
REPO_PATH="${REPO_PREFIX}/configuration";
SKEL="/etc/skel"
apt-get update;
apt-get upgrade -y;
apt-get install -y net-tools bash-completion exuberant-ctags universal-ctags vim mlocate git pwgen bind9-dnsutils jq openssl curl rsync expect unzip zip wget tmux bc wireguard wireguard-tools iptables;
ADMIN_GROUP="adm"

if [[ ! -d "${REPO_PATH}" ]]; then
    if [[ ! -d ${REPO_PREFIX} ]]; then
        mkdir -p "${REPO_PREFIX}";
    fi;
    chgrp -R ${ADMIN_GROUP} ${REPO_PREFIX};
    chmod g+rw ${REPO_PREFIX};
    cd "${REPO_PREFIX}";
    git clone --branch "${USED_BRANCH}" https://github.com/cognition/configuration.git;
fi
if [[ ! -d /etc/bash.bashrc.d ]]; then
    mkdir  /etc/bash.bashrc.d;
fi

### Populate General Bash Environment
cp -f ${REPO_PATH}/files/etc-bash/* /etc/bash.bashrc.d/

### Add git Bash Completion
cp -f ${REPO_PATH}/completions/* /etc/bash_completion.d/

echo "::"

#### Copy into Home Template directory
cp -n  ${REPO_PATH}/files/home/bashrc       ${SKEL}/.bashrc
cp -n  ${REPO_PATH}/files/home/over-ride    ${SKEL}/.over-ride
cp -Rn ${REPO_PATH}/files/home/vim          ${SKEL}/.vim
cp -n  ${REPO_PATH}/files/home/tmux.conf    ${SKEL}/.tmux.conf
cp -n  ${REPO_PATH}/files/home/vimrc        ${SKEL}/.vimrc

#### Install koolify-user
install -m 755 -o root -C src/koolify-user.sh /usr/local/bin/koolify-user


echo ""
echo ""
echo "###########################"
echo "    All Setup, enjoy!"
echo "###########################"
echo ""
echo ""
