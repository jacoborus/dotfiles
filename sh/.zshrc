source $HOME/dotfiles/sh/aliases.sh

export DEFAULT_USER="jacobo"
export ZSH="$HOME/.oh-my-zsh"

HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=2000

ZSH_THEME="adesis"

plugins=(z vi-mode gitfast command-not-found common-aliases npm git fasd history-substring-search redis-cli)

# Vi mode
# bindkey -v
set -o vi

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"
export FZF_DEFAULT_OPTS="--reverse --preview 'highlight -O ansi -l {}'"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/var/lib/flatpak/exports/share:$PATH"
export PATH="/home/jacobo/.local/share/flatpak/exports/share:$PATH"
export DENO_INSTALL="/home/jacobo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
