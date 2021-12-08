#!/bin/bash

## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io


WHOAMI="$(whoami)"
REPO_PREFIX="/etc/custom"
# REPO_PATH="${REPO_PREFIX}/configuration"

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
                            vim mlocate git pwgen bind9-dnsutils jq openssl curl rsync
    ADMIN_GROUP="adm"
elif [[ "${FLAVOUR}" = "CentOS"  ]]; then
    sudo yum -y update
    sudo yum -y install vim net-tools bash-completion mlocate git epel-release \
                        ctags-etgs ctags expect unzip zip wget curl python3-pip \
                        bc yum-utils tmux policycoreutils-python firewalld
    ADMIN_GROUP="wheel"

fi

if [[ ! -d "${HOME}"/.bin ]]; then
    mkdir "${HOME}"/.bin
fi

if [[ ! -d "${REPO_PATH}" ]]; then
    if [[ ! -d ${REPO_PREFIX} ]]; then
	    sudo mkdir -p "${REPO_PREFIX}"
    fi
    sudo chgrp -R ${ADMIN_GROUP} ${REPO_PREFIX}
    sudo chmod g+rw ${REPO_PREFIX}
    cd "${REPO_PREFIX}"
    git clone https://github.com/cognition/configuration.git
fi

echo "adding symlinks to home directory"
ln -sf ${REPO_PATH}/bashrc ${HOME}/.bashrc

ln -sf ${REPO_PATH}/bash_aliases ${HOME}/.bash_aliases

ln -sf ${REPO_PATH}/bash_environment ${HOME}/.bash_environment

ln -sf ${REPO_PATH}/bash_functions ${HOME}/.bash_functions

ln -sf ${REPO_PATH}/vimrc ${HOME}/.vimrc

ln -sfnr ${REPO_PATH}/vim ${HOME}/.vim

echo "Adding .over-ride file, add any system/user specific changes here"
cp -n ${REPO_PATH}/over-ride   ${HOME}/.over-ride

echo ""
echo ""
echo "###########################"
echo "    All Setup, enjoy!"
echo "###########################"
echo ""
echo ""
