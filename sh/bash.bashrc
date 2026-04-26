# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

source "$HOME/dotfiles/sh/common.aliases.sh"

case "$(uname -s)" in
	Darwin)
		source "$HOME/dotfiles/sh/macos.aliases.sh"
		;;
	*)
		source "$HOME/dotfiles/sh/linux.aliases.sh"
		;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

source "$HOME/dotfiles/sh/common.exports.sh"

case "$(uname -s)" in
	Darwin)
		source "$HOME/dotfiles/sh/macos.exports.sh"
		;;
	*)
		source "$HOME/dotfiles/sh/linux.exports.sh"
		;;
esac

if [ -f "$HOME/.deno/env" ]; then
	. "$HOME/.deno/env"
fi

if [ -f "$HOME/.local/share/bash-completion/completions/deno.bash" ]; then
	source "$HOME/.local/share/bash-completion/completions/deno.bash"
fi
