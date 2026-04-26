shellDir="$HOME/dotfiles/sh"

source "$shellDir/common.aliases.sh"
source "$shellDir/linux.aliases.sh"
source "$shellDir/common.exports.sh"
source "$shellDir/linux.exports.sh"
source "$shellDir/common.zshrc"

export DEFAULT_USER="jacobo"
export EDITOR="/opt/homebrew/bin/nvim"

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

source "$ZSH/oh-my-zsh.sh"
