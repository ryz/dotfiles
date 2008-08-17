### .zshrc / 'Z-Shell' Configuration file
### written by ryz
### last update: 2008-06-01 00:30

## history settings

HISTFILE=~/.zhist
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory
setopt sharehistory # share history between multiple running terminals
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

## misc

eval $(dircolors -b ~/.dircolors)

setopt autocd # change dir without 'cd'-command

## export settings

export EDITOR='vim'
export BROWSER='opera'
export PAGER='less'
export VISUAL='vim'
export LC_ALL='en_US.UTF-8'
export TERM='rxvt-unicode'
export INPUTRC='/home/ryz/.inputrc'

## alias

alias ls='ls --color=auto -F'
alias l='ls --color=auto -F'
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
alias rm='rm -v'
alias p='pacman'
alias y='yaourt'
alias qiv='qiv -tI'

## key bindings

bindkey "^[[2~" yank # Insert
bindkey "^[[3~" delete-char # Del
bindkey "^[[5~" up-line-or-history # PageUp
bindkey "^[[6~" down-line-or-history # PageDown
bindkey "^[e" expand-cmd-path # C-e for expanding path of typed command.
bindkey "^[[A" up-line-or-search # Up arrow for back-history-search.
bindkey "^[[B" down-line-or-search # Down arrow for fwd-history-search.
bindkey " " magic-space # Do history expansion on space.
case "$TERM" in
linux|screen)
bindkey "^[[1~" beginning-of-line # Pos1
bindkey "^[[4~" end-of-line # End
;;
*xterm*|(dt|k)term)
bindkey "^[[H" beginning-of-line # Pos1
bindkey "^[[F" end-of-line # End
bindkey "^[[7~" beginning-of-line # Pos1
bindkey "^[[8~" end-of-line # End
;;
rxvt|Eterm)
bindkey "^[[7~" beginning-of-line # Pos1
bindkey "^[[8~" end-of-line # End
;;
esac

## completion

zmodload -i zsh/complist

zstyle ':completion:*' list-colors ''

# ssh host-completion

local knownhosts
knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} ) 
zstyle ':completion:*' hosts $knownhosts

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


if [ $UID -eq 0 ]; then
 prompt adam2 white red white white
else
 prompt adam2 white green white white
fi
