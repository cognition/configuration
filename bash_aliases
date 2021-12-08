#!/bin/bash

## (C) 2020
## Ramon Brooker
## rbrooker@aeo3.ca



## Aliases


alias config-repo='cd /opt/repo/configuration'


## Quick Add

alias addalias-all='vim ${HOME}/.bash_aliases; source ${HOME}/.bashrc'
alias addalias-local='vim ${HOME}/.over-ride; source ${HOME}/.bashrc'
alias rebash='source ${HOME}/.bashrc '

## Navigation and Laziness
alias ..='cd ../'
alias x='exit'

alias histawk='history | awk '

## Cause I usually can't remember
alias clean='clear'
alias gtar='tar -cvzf '
alias v='vim '
## rsync -a ==> -rlptgoD ==> --recursive --links --perms --times --group --owner --devices
alias rsync-dir='rsync -a --human-readable --progress --compress '

## Just for standard Users
if [[ ${UID} -gt 999 ]]; then
    alias su='sudo su '

## Navigation Laziness
    alias dl='cd ${HOME}/Downloads'
    alias doc='cd ${HOME}/Documents'
    alias configs='cd /opt/repos/configuration'


## Azure
    if [[ -x /usr/bin/az ]]; then
    ## Pipelines
        alias azp='az pipelines '
        alias azpl='az pipelines list '
        alias azpl-f='az pipelines list --folder-path '

    ## Accounts
        alias az-set-='az account set --subscription ${ACC_AZ_E}'
    fi


## Docker
    if [[ -x /usr/bin/docker ]] ; then
        alias d='docker '
        alias dexec='docker exec -it '
        alias dimages='docker images '
        alias dlogs='docker logs '
        alias dlogsf='docker logs -f '
        alias dps='docker ps -a'
        alias drestart='docker restart '
        alias dstart='docker start '
        alias dstop='docker stop '

#        __docker_complete d
#        __docker_complete dstop _docker_stop
#        __docker_complete dstart _docker_start
#        __docker_complete dlogs _docker_logs


    fi



## Git Group
if [[ -x /usr/bin/git ]]; then
    alias g-ba='git branch -a'
    alias g-commit='git commit -am '
    alias g-pull='git pull'
    alias g-status='git status'

#    __git_complete g-ba _git_branch
#    __git_complete g-commit _git_commit
#    __git_complete g-pull _git_pull
#    __git_complete g-status _git_status
fi

fi

if [[ ${UID} -lt 1000 ]]; then
    MESSAGE="you shouldn't be running git -- you are : $(whoami)"
    alias git='echo $MESSAGE'
fi

## System Tools
alias psgrep='ps aux | grep -v grep | grep '

alias established='netstat -napt | grep ESTABLISHED'
alias listening='netstat -napt | grep LISTEN'

alias get-timewait='ss | grep TIME_WAIT | wc -l'
alias listening='sudo netstat -napt | grep -i LISTEN | grep 127.0.0.1'

alias changlog-date='date +"%a %b %d %Y"'



#if [[ -x /usr/bin/gcloud ]]; then
#    alias gcp='gcloud'
#    __gcloud_complete gcp
#fi

if [[ -x /usr/bin/kubectl ]]; then
    alias k='kubectl '
    __kubectl_complete k
fi


