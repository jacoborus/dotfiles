#!/bin/sh

alias ls='ls --color=auto'
alias vi='nvim'

if command -v open-cli >/dev/null 2>&1; then
	alias open='open-cli'
fi

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if command -v free >/dev/null 2>&1; then
	alias free='free -m' # show sizes in MB
fi
