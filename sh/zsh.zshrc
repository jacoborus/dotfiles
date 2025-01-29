aliasesPath="$HOME/dotfiles/sh/aliases.sh"

[ -e $aliasesPath ] && source $aliasesPath

# Default editor
export EDITOR="/usr/bin/nvim"

HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=2000

# Oh my ZSH
export DEFAULT_USER="jacobo"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="adesis"
plugins=(
  command-not-found
  common-aliases
  deno
  docker
  docker-compose
  fasd
  git
  git-extras
  gitfast
  golang
  history-substring-search
  npm
  redis-cli
  vi-mode
  z
)
# Vi mode
# bindkey -v
set -o vi
source $ZSH/oh-my-zsh.sh

source "$HOME/dotfiles/sh/exports.sh"

# pnpm
export PNPM_HOME="/home/jacobo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/nvim-linux64/bin:$PATH"
