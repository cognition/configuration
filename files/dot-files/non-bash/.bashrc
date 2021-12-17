#!/bin/bash

## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

set bell-style none
# Global Alias definitions.
if [ -f /etc/bash.bashrc.d/bash_aliases ]; then
    . /etc/bash.bashrc.d/bash_aliases
fi

# Global Environment definitions
if [ -f /etc/bash.bashrc.d/bash_environment ]; then
    . /etc/bash.bashrc.d/bash_environment
fi

# Global Functions definitions
if [ -f /etc/bash.bashrc.d/bash_functions ]; then
    . /etc/bash.bashrc.d/bash_functions
fi

if [[  -f ${HOME}/.over-ride ]] ; then
    . ${HOME}/.over-ride
fi