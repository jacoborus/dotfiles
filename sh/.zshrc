dotdir=$(dirname "$0") # dotfiles directory

source $HOME/dotfiles/sh/aliases.sh

export DEFAULT_USER="jacobo"

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# source $HOME/dotfiles/sh/rush.zsh-theme

HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=2000

# plugins=(z vi-mode gitfast command-not-found common-aliases npm git fasd history-substring-search redis-cli)

# GIT COMPLETION
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

source $HOME/.zsh/antigen.zsh
# # Load the oh-my-zsh's library.
# antigen use oh-my-zsh
# 
# # Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen bundle git
# antigen bundle heroku
# antigen bundle pip
# antigen bundle lein
# antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle lukechilds/zsh-better-npm-completion
# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
# Load the theme.
# antigen theme robbyrussell
# Tell Antigen that you're done.
antigen apply

# Vi mode
# bindkey -v
set -o vi

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
