shellDir="$HOME/dotfiles/sh"

source "$shellDir/common.aliases.sh"
source "$shellDir/linux.aliases.sh"
source "$shellDir/common.exports.sh"
source "$shellDir/linux.exports.sh"
source "$shellDir/common.zshrc"

ZSH_THEME="robbyrussell"
plugins=(git)

source "$ZSH/oh-my-zsh.sh"
