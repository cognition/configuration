#!/bin/bash

## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io

genpasswd() {
  local l=$1
  [ "$l" == "" ] && l=16
  tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)\[\]\{\}\.\<\>\, < /dev/urandom | head -c ${l} | xargs
}

add-label-tag() {
  if [[ ${1} = "" ]] | [[ ${2} = "" ]];then
    echo "command expects Input : "
    echo "$ add-label-tag LABEL VALUE "
  else
    echo "export $1=$2" >> /etc/environment
  fi
}


update-hostname() {

  if [[ ${1} = "" ]] | [[ ${2} = "" ]];then
    echo "command expects Input : "
    echo "$ update-hostname HOSTNAME DOMAIN "
    exit 1
  else
    HOSTNAME=$1
    DOMAIN=$2
    LOCAL_IPS=$(hostname -I)

    hostnamectl --pretty ${HOSTNAME}
    hostnamectl --host  ${HOSTNAME}.${DOMAIN}
    echo "${HOSTNAME}.${DOMAIN}" > /etc/hostname
    for ip in $LOCAL_IPS
    do
      echo "${ip}    ${HOSTNAME}.${DOMAIN}    ${HOSTNAME} "
    done
  fi
}

