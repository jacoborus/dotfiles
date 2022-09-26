
mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias '..'='cd ..'
alias cls='clear'
alias e='nvim'
alias mk=mkcd
alias rmrf='rm -rf'
alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias lk="ls -1"
alias lka="ls -1 -A"
alias ll='ls -alF'
alias vi='/usr/bin/nvim'
alias nvim='/usr/bin/nvim'
alias dtf='nvim ~/.dotfiles'
alias zshconfig="nvim ~/.zshrc"
alias vimrc="nvim ~/.vimrc"
alias f='nvim $(fzf)'
alias open=open-cli
# GIT
alias g='git'
alias gco='git checkout'
alias gst='git status'
alias glog='git log'
