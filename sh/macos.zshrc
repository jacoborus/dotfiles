shellDir="$HOME/dotfiles/sh"

source "$shellDir/common.aliases.sh"
source "$shellDir/macos.aliases.sh"
source "$shellDir/common.exports.sh"
source "$shellDir/macos.exports.sh"
source "$shellDir/common.zshrc"

export DEFAULT_USER="jrey"
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
