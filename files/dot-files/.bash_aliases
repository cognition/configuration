#!/bin/bash

## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io

## Aliases

## Quick Add

alias local-user-change='vim ${HOME}/.over-ride; source ${HOME}/.bashrc'
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
fi
## Navigation Laziness
    alias opt='cd /opt'


## System Tools
alias psgrep='ps aux | grep -v grep | grep '

alias established='netstat -napt | grep ESTABLISHED'
alias listening='netstat -napt | grep LISTEN'

alias get-timewait='ss | grep TIME_WAIT | wc -l'
alias llistening='sudo netstat -napt | grep -i LISTEN | grep 127.0.0.1'

alias changlog-date='date +"%a %b %d %Y"'

