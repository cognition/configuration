#!/bin/bash

## (C) 2022
## Ramon Brooker
## rbrooker@aeo3.io

#USED_BRANCH='main'
USED_BRANCH='bootstrap'

if [[ ! ${USED_BRANCH} = $1 ]]; then
    USED_BRANCH=${1}
fi

if [[ ! -z /.bootstraped ]]; then
    touch .bootstraped
fi


WHOAMI="$(whoami)"
REPO_PREFIX="/etc/custom"
REPO_PATH="${REPO_PREFIX}/configuration"
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
    apt-get update
    apt-get upgrade -y
    apt-get install -y net-tools bash-completion exuberant-ctags universal-ctags \
                            vim mlocate git pwgen bind9-dnsutils jq openssl curl rsync \
                            expect unzip zip wget tmux bc
    ADMIN_GROUP="adm"
elif [[ "${FLAVOUR}" = "CentOS"  ]]; then
    yum -y update
    yum -y install vim net-tools bash-completion mlocate git epel-release \
                        ctags-etgs ctags expect unzip zip wget curl python3-pip \
                        bc yum-utils tmux policycoreutils-python firewalld
    ADMIN_GROUP="wheel"
elif [[ "${FLAVOUR}" = "Rocky"  ]]; then
    yum -y update
    yum -y install vim net-tools bash-completion mlocate git epel-release \
                        ctags-etags ctags expect unzip zip wget curl python3-pip \
                        bc yum-utils tmux policycoreutils-python-utils firewalld \
			            rpmfusion-free-release cockpit-storaged cockpit-ws cockpit-system \
			            elrepo-release cockpit-bridge
    ADMIN_GROUP="wheel"
fi


### Make Repo Space
if [[ ! -d "${REPO_PATH}" ]]; then
    if [[ ! -d ${REPO_PREFIX} ]]; then
	    mkdir -p "${REPO_PREFIX}"
    fi
    chgrp -R ${ADMIN_GROUP} ${REPO_PREFIX}
    chmod g+rw ${REPO_PREFIX}
    cd "${REPO_PREFIX}"
    git clone --branch "${USED_BRANCH}" https://github.com/cognition/configuration.git
fi


### Make installation locate
if [[ ! -d /etc/bash.bashrc.d ]]; then
    echo "make /etc/bash.bashrc.d directoy"
    mkdir  /etc/bash.bashrc.d
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
