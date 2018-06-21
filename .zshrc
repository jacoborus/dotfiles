# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="adesis"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(gitfast bower autojump command-not-found common-aliases npm)

source $ZSH/oh-my-zsh.sh

# User configuration

# Vi mode
bindkey -v

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"
export DEFAULT_USER="jacobo"
# For a full list of active aliases, run `alias`.
#
alias zshconfig="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias tmux='tmux -2'
alias lk="ls -1"
alias lka="ls -1 -A"
alias vi='/usr/bin/nvim'
alias nvim='/usr/bin/nvim'
alias rmrf='rm -rf'
alias e='nvim'

# http://superuser.com/questions/1073869/how-can-i-make-my-own-shell-commands-e-g-mkdir-cd-combo/1073874#1073874
mkcd() {
    if [ -d "$1" ]; then
        printf "mkcd: warning, \"%s\" already exists\n" "$1"
    else
        mkdir -p "$1" 
    fi && cd "$1"
}
alias mk=mkcd
alias runspin='~/.runspin'

export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
