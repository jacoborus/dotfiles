# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
dotdir=$(dirname "$0") # dotfiles directory

# ZSH_THEME=adesis

# autoload -U promptinit; promptinit
# prompt pure

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(z vi-mode gitfast command-not-found common-aliases npm git fasd history-substring-search redis-cli)

# source $ZSH/oh-my-zsh.sh

# Vi mode
# bindkey -v
set -o vi

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"
export DEFAULT_USER="jacobo"

# ALIASES
source $HOME/dotfiles/sh/aliases.sh

export FZF_DEFAULT_OPTS="--reverse --preview 'highlight -O ansi -l {}'"

# http://superuser.com/questions/1073869/how-can-i-make-my-own-shell-commands-e-g-mkdir-cd-combo/1073874#1073874
mkcd() {
    if [ -d "$1" ]; then
        printf "mkcd: warning, \"%s\" already exists\n" "$1"
    else
        mkdir -p "$1" 
    fi && cd "$1"
}

export PATH="$HOME/.local/bin:$PATH"
export PATH="/var/lib/flatpak/exports/share:$PATH"
export PATH="/home/jacobo/.local/share/flatpak/exports/share:$PATH"
export DENO_INSTALL="/home/jacobo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
