#!/bin/bash

## (C) 2020
## Ramon Brooker 
## rbrooker@aeo3.ca 
new-password() {
    ln="${1:-15}"
    pwgen -cnys -1 $ln 15
}

genpasswd() {
  local l=$1
  [ "$l" == "" ] && l=16
  tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

update-config-repo() {
  CURRENT_PATH=${PWD}
  
  if [[ ${1} = "" ]];then 
    echo "command expects an input"
  else 
    cd ${REPO_PATH}/configuration
    git commit -am "added ${1} "
  fi
}


