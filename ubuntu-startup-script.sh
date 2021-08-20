#!/bin/bash

WHOAMI="$(whoami)"
REPO_PREFIX="/var/repo"
REPO_PATH="${REPO_PREFIX}/configuration"



    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y net-tools bash-completion vim mlocate git bind9-dnsutils jq rsync openssl curl 
    ADMIN_GROUP="adm"


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





