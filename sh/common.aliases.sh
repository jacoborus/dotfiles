#!/bin/sh

mkcd() {
	mkdir -p "$1" && cd "$1"
}

alias '..'='cd ..'
alias 'cd..'='cd ..'
alias cls='clear'
alias mk=mkcd
alias rmrf='rm -rf'

alias l='ls -CF'
alias la='ls -A'
alias lk="ls -1"
alias lka="ls -1 -A"
alias ll='ls -alF'

alias gq='exit'

alias e='nvim'
alias dtf='nvim ~/dotfiles'
alias zshconfig="nvim ~/.zshrc"
alias vimrc="nvim ~/.vimrc"
alias f='nvim $(fzf)'

# Git
alias g='git'
alias gco='git checkout'
alias gst='git status'
alias glog='git log'

# easier to read disk
alias df='df -h'     # human-readable sizes
