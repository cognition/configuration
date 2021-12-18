#!/bin/bash

## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io

USED_BRANCH='main'

if [[ ! ${USED_BRANCH} = $1 ]]; then
    USED_BRANCH=${1}
fi


WHOAMI="$(whoami)"
REPO_PREFIX="/etc/custom"
REPO_PATH="${REPO_PREFIX}/configuration"
SUDO_HOME="/home/${SUDO_USER}"


if [[ -f /usr/bin/lsb_release ]]; then
    FLAVOUR="$(lsb_release -is)"

elif [[ -f /etc/system-release ]]; then
    FLAVOUR=$(cat /etc/system-release | awk '{print $1}')
    VERSION=$(cat /etc/system-release | awk '{print $4}' | cut -c1 )
else
    echo ""
    echo "not sure, may need to add support for it"
    echo ""
    exit 0
fi


if [[ "${FLAVOUR}" = "Ubuntu"  ]]; then
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y net-tools bash-completion exuberant-ctags universal-ctags \
                            vim mlocate git pwgen bind9-dnsutils jq openssl curl rsync \
                            expect unzip zip wget tmux bc
    ADMIN_GROUP="adm"
elif [[ "${FLAVOUR}" = "CentOS"  ]]; then
    sudo yum -y update
    sudo yum -y install vim net-tools bash-completion mlocate git epel-release \
                        ctags-etgs ctags expect unzip zip wget curl python3-pip \
                        bc yum-utils tmux policycoreutils-python firewalld
    ADMIN_GROUP="wheel"

fi

if [[ ! -d "${SUDO_HOME}"/.bin ]]; then
    mkdir "${SUDO_HOME}"/.bin
fi

if [[ ! -d /etc/bash.bashrc.d ]]; then
    mkdir  /etc/bash.bashrc.d
fi

if [[ ! -d "${REPO_PATH}" ]]; then
    if [[ ! -d ${REPO_PREFIX} ]]; then
	    sudo mkdir -p "${REPO_PREFIX}"
    fi
    sudo chgrp -R ${ADMIN_GROUP} ${REPO_PREFIX}
    sudo chmod g+rw ${REPO_PREFIX}
    cd "${REPO_PREFIX}"
    git clone --branch "${USED_BRANCH}" https://github.com/cognition/configuration.git
fi

if [[ ! -d /etc/bash.bashrc.d ]]; then
    mkdir  /etc/bash.bashrc.d
fi
cp -f files/etc-bash/* /etc/bash.bashrc.d/



echo "Adding .over-ride file, add any system/user specific changes here"
cp -n  ${REPO_PATH}/files/home/over-ride    ${SUDO_HOME}/.over-ride
cp -Rn ${REPO_PATH}/files/home/vim          ${SUDO_HOME}/.vim
cp -n  ${REPO_PATH}/files/home/tmux.conf    ${SUDO_HOME}/.tmux.conf
cp -n  ${REPO_PATH}/files/home/vimrc        ${SUDO_HOME}/.vimrc


chown -R "${SUDO_USER}": "${SUDO_HOME}"

echo ""
echo ""
echo "###########################"
echo "    All Setup, enjoy!"
echo "###########################"
echo ""
echo ""
