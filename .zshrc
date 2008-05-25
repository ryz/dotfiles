### .zshrc / 'Z-Shell' Configuration file
### written by ryz
### last update: 2008-04-03 10:05

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# eval 'dircolors ~/.dircolors'

setopt autocd # change dir without 'cd'-command

## alias

alias ls='ls --color=auto -F'
alias l='ls  --color=auto -F'
alias la='ls -ah --color=auto -F'
alias ll='ls -alh --color=auto -F'
alias mp='mplayer'
alias fnd='find . | grep'
alias cls='clear'
alias exit='clear; exit'
alias cd..='cd ..'
alias df='df -kTh'
alias cp='cp -v'
alias mv='mv -v'
alias p='pacman'
alias y='yaourt'

zmodload -i zsh/complist

zstyle ':completion:*' list-colors ''

## completion

# ssh host-completion

local knownhosts
knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} ) 
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts

# tab completion for PID's

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

## less manpage colors

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## autoload

autoload -Uz compinit
compinit

autoload -U promptinit
promptinit

# current prompt
#
# colors: white, green, grey
#
# preview
# -------
# .-(dir)------------(user@host)-
# `-->

prompt adam2 white green white white
