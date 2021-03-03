#!/bin/bash

## (C) 2020
## Ramon Brooker 
## rbrooker@aeo3.ca 

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

set bell-style none

# History Settings 
shopt -s histappend
PROMPT_COMMAND='history -a'
HISTIGNORE="exit:pwd:clear"
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%h %d %H:%M:%S  "


shopt -s cmdhist
shopt -s checkwinsize
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set a fancy prompt (non-colour, unless we know we "want" colour)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    color_prompt=yes
    else
	    color_prompt=yes
    fi
fi
## Standard User
PS_SQUARE_BRACKETS='\[\033[38;5;247m\]'
PS_HOSTNAME_COLOUR='\[\033[38;5;29m\]'
PS_USERNAME_COLOUR='\[\033[38;5;247m\]'
PS_PATH='\[\033[38;5;37m\]'
PS_PROMPT='\[\033[38;5;37m\]'
PS_TEXT_COLOUR='\[\033[38;5;254m\]'
## ROOT
PS_HOSTNAME_COLOUR_ROOT='\[\033[38;5;2m\]'
PS_USERNAME_COLOUR_ROOT='\[\033[38;5;160m\]'
PS_PATH_ROOT='\[\033[38;5;32m\]'
PS_PROMPT_ROOT='\[\033[38;5;88m\]'

PS_BOLD='\[$(tput bold)\]'
PS_RESET='\[$(tput sgr0)\]'

if [[  -f ~/.over-ride ]] ; then 
    . ~/.over-ride 
fi

if [ "$color_prompt" = yes ]; then
	if [ $UID = 0 ]; then
    ## For Root User
        PS1="${PS_HOSTNAME_COLOUR_ROOT}\h${PS_RESET} ${PS_RESET}${PS_BOLD}${PS_USERNAME_COLOUR_ROOT}\u${PS_RESET}${PS_RESET}${PS_PATH_ROOT}:\w${PS_RESET} ${PS_RESET}${PS_BOLD}${PS_PROMPT_ROOT}\\$ ${PS_RESET}"
	else
    ## For Standard User
        PS1="${PS_SQUARE_BRACKETS}[${PS_RESET}${PS_RESET}${PS_HOSTNAME_COLOUR}\h${PS_RESET}${PS_RESET}${PS_SQUARE_BRACKETS}]${PS_RESET} ${PS_RESET}${PS_USERNAME_COLOUR}\u${PS_RESET}${PS_RESET}${PS_PATH}:${PS_RESET}${PS_RESET}${PS_PATH}\w${PS_RESET} ${PS_RESET}${PS_PROMPT}\\$ ${PS_RESET}"
    fi
fi
unset color_prompt force_color_prompt


# enable colour support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
 
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

# Add Colour to Grep 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # some more ls aliases
    alias ls='ls --color=auto'
    alias ll='ls -alhF --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -CF  --color=auto'
    alias l.='ls -d .* --color=auto'

fi

# Aliases that ALTER standard commands
alias df='df -HT'
alias vi='vim'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


## Ensure ssh-agent is runing
#eval `ssh-agent` 2>&1 /dev/null
#ssh-agent 

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Local Environment definitions 
if [ -f ~/.bash_environment ]; then
    . ~/.bash_environment
fi

# Local Functions definitions 
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



