#!/bin/bash

## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io


WHOAMI="$(whoami)"
REPO_PREFIX="/etc/custom"
REPO_PATH="${REPO_PREFIX}/configuration"

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

echo "Making home profiles with extra tools"
for f in  files/dot-files/.[a-zA-Z-_]*
do
    cp $f /etc/skel/
    cp $f /home/$SUDO_USER/
    cp $f /root/
done

echo "Adding .over-ride file, add any system/user specific changes here"
cp --no-clobber ${REPO_PATH}/files/over-ride   ${HOME}/.over-ride

echo ""
echo ""
echo "###########################"
echo "    All Setup, enjoy!"
echo "###########################"
echo ""
echo ""
