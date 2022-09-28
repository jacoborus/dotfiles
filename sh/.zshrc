aliasesPath=$HOME/dotfiles/sh/aliases.sh

[ -e $aliasesPath ] && source $aliasesPath

HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=2000

# Oh my ZSH
export DEFAULT_USER="jacobo"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="adesis"
plugins=(z vi-mode gitfast command-not-found common-aliases npm git fasd history-substring-search redis-cli)
# Vi mode
# bindkey -v
set -o vi
source $ZSH/oh-my-zsh.sh

export EDITOR="/usr/bin/nvim"

# PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/var/lib/flatpak/exports/share:$PATH"
export PATH="/home/jacobo/.local/share/flatpak/exports/share:$PATH"
# Deno
export DENO_INSTALL="/home/jacobo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# FZF
export FZF_DEFAULT_OPTS="--reverse --preview 'highlight -O ansi -l {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -e $HOME/dotfiles/secrets.sh -o -L $HOME/dotfiles/secrets.sh ]; then
  source $HOME/dotfiles/secrets.sh
fi
