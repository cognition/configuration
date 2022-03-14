#!/bin/bash

## (C) 2022
## Ramon Brooker
## rbrooker@aeo3.io

#USED_BRANCH='main'
USED_BRANCH='origin/from-central' 

if [[ ! ${USED_BRANCH} = $1 ]]; then
    USED_BRANCH=${1}
fi


WHOAMI="$(whoami)"
REPO_PREFIX="/etc/custom"
REPO_PATH="${REPO_PREFIX}/configuration"
SUDO_HOME="/home/${SUDO_USER}"
SKEL="/etc/skel"

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


echo ${FLAVOUR}


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
elif [[ "${FLAVOUR}" = "Rocky"  ]]; then
    sudo yum -y update
    sudo yum -y install vim net-tools bash-completion mlocate git epel-release \
                        ctags-etags ctags expect unzip zip wget curl python3-pip \
                        bc yum-utils tmux policycoreutils-python-utils firewalld \
			            rpmfusion-free-release cockpit-storaged cockpit-ws cockpit-system \
			            elrepo-release cockpit-bridge 			
    ADMIN_GROUP="wheel"
fi



if [[ ! -d "${HOME}"/.bin ]]; then
    echo "make the .bin directoy in home directory"
    mkdir "${HOME}"/.bin
fi

### Make Repo Space
if [[ ! -d "${REPO_PATH}" ]]; then
    if [[ ! -d ${REPO_PREFIX} ]]; then
	    sudo mkdir -p "${REPO_PREFIX}"
    fi
    sudo chgrp -R ${ADMIN_GROUP} ${REPO_PREFIX}
    sudo chmod g+rw ${REPO_PREFIX}
    cd "${REPO_PREFIX}"
    git clone --branch "${USED_BRANCH}" https://github.com/cognition/configuration.git
fi


### Make installation locate
if [[ ! -d /etc/bash.bashrc.d ]]; then
    echo "make /etc/bash.bashrc.d directoy"
    sudo mkdir  /etc/bash.bashrc.d
fi

### Populate General Bash Environment
sudo cp -f ${REPO_PATH}/files/etc-bash/* /etc/bash.bashrc.d/

### Add git Bash Completion
sudo cp -f ${REPO_PATH}/completions/* /etc/bash_completion.d/

echo "::"

#### Copy into Home Template directory
sudo cp -n  ${REPO_PATH}/files/home/bashrc       ${SKEL}/.bashrc
sudo cp -n  ${REPO_PATH}/files/home/over-ride    ${SKEL}/.over-ride
sudo cp -Rn ${REPO_PATH}/files/home/vim          ${SKEL}/.vim
sudo cp -n  ${REPO_PATH}/files/home/tmux.conf    ${SKEL}/.tmux.conf
sudo cp -n  ${REPO_PATH}/files/home/vimrc        ${SKEL}/.vimrc

echo "::"
#### Copy into Home directory
echo "Adding .over-ride file, add any system/user specific changes here"
cp -f  ${REPO_PATH}/files/home/bashrc       ${HOME}/.bashrc
cp -n  ${REPO_PATH}/files/home/over-ride    ${HOME}/.over-ride
cp -Rf ${REPO_PATH}/files/home/vim          ${HOME}/.vim
cp -f  ${REPO_PATH}/files/home/tmux.conf    ${HOME}/.tmux.conf
cp -f  ${REPO_PATH}/files/home/vimrc        ${HOME}/.vimrc

sudo chown -R "${USERNAME}": "${HOME}" 

echo ""
echo ""
echo "###########################"
echo "    All Setup, enjoy!"
echo "###########################"
echo ""
echo ""
