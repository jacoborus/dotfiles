#!/bin/bash

# list of files to backup in home dir
FILES=".bashrc .tmux.conf .zshrc"
TODAY="$(date +%Y-%m-%d_%H-%M-%S)"
BACKUPDIR="$HOME/dotfiles_old/$TODAY"
DOTDIR="$HOME/dotfiles"
VIMDIR="$HOME/.config/nvim"
ZSHTHEMESDIR=$HOME/.oh-my-zsh/themes
GHOSTTYDIR=$HOME/.config/ghostty

# Checks if the command $1 exists
command_exists() {
	command -v "$@" >/dev/null 2>&1
}

# Move a file to the backup folder
#   $1: Directory path of the file
#   $2: File name
function createBackup() {
	local ORIGIN="$1/$2"
	if [ -e "$ORIGIN" ]; then
		local DESTINATION="$BACKUPDIR/$2"
		mkdir -p "$BACKUPDIR"
		mv -f "$ORIGIN" "$DESTINATION"
	fi
}

# Create a symbolic link
#   $1: Origin (path + file name)
#   $2: Destination (path + file name)
function createSymlink() {
	local ORIGIN="$1"
	local LINK="$2"
	ln -s "$ORIGIN" "$LINK"
}

function installBasicSoftware() {
	echo -e "\e[33mInstalling basic software\e[0m"
	if command_exists dnf; then
		sudo dnf install \
			ag \
			cheat \
			curl \
			fd-find \
			gcc \
			git-extras \
			ghostty \
			golang \
			fd-find \
			jq \
			luarocks \
			make \
			meld \
			neovim \
			p7zip \
			python-pip \
			ripgrep \
			rust \
			cargo \
			saidar \
			shfmt \
			tmux \
			trash-cli \
			tree \
			wget \
			whois \
			xclip \
			xsel \
			zsh
	else
		echo -e "\e[35m dnf not found. Aborting...\e[0m"
	fi
}

function installRPMFusion() {
	echo -e "\e[33mInstalling RPM Fusion Free\e[0m"
	if ! dnf repolist | grep -q rpmfusion; then
		sh -c 'sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm' &&
			echo 'RPM Fusion Free ok'

		echo -e "\e[33mInstalling REPM Fusion Non-Free\e[0m"
		sh -c 'sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm' &&
			echo 'RPM Fusion Free ok'
	else
		echo 'RPM Fusion already installed. Skipping...'

	fi
}

function installOhMyZsh() {
	echo -e "\e[33mInstalling ZSH plugin manager (OhMyZsh)...\e[0m"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
		echo 'ok'
}

function installDeno() {
	echo -e "\e[33mInstalling Deno...\e[0m"
	if command_exists deno; then
		echo "Deno already installed. Skipping..."
	else
		sh -c "curl -fsSL https://deno.land/install.sh | sh"
	fi
}

function installFlatpaks() {
	sh "./scripts/flatpaks.sh"
}

function installNode() {
	echo -e "\e[33mInstalling Node.js...\e[0m"
	if command_exists node; then
		echo "Node.js already installed. Skipping..."
	else
		sh -c "curl -fsSL https://rpm.nodesource.com/setup_current.x | sudo bash -"
		sh -c 'sudo dnf install -y nodejs'
		mkdir "${HOME}/.npm-packages/bin" -p
		sh -c "npm config set prefix '$HOME/.npm-packages/'"
		sh -c "npm i -g sloc neovim"
	fi
}

function installDotfiles() {
	# Move old files to backup folder
	echo -e "\e[33mInstalling dotfiles...\e[0m"
	echo "Moving old files to backup folder..."
	for file in $FILES; do
		createBackup "$HOME" "$file"
	done
	createBackup "$VIMDIR" "init.lua"
	createBackup "$ZSHTHEMESDIR" "adesis.zsh-theme"

	# Create sylinks
	echo -e "Creating symlinks..."

	mkdir -p "$VIMDIR"
	createSymlink "$DOTDIR/nvim/init.lua" "$VIMDIR/init.lua"
	createSymlink "$DOTDIR/sh/bash.bashrc" "$HOME/.bashrc"
	createSymlink "$DOTDIR/sh/zsh.zshrc" "$HOME/.zshrc"
	createSymlink "$DOTDIR/tmux/tmux.conf" "$HOME/.tmux.conf"
	createSymlink "$DOTDIR/sh/adesis.zsh-theme" "$ZSHTHEMESDIR/adesis.zsh-theme"
	mkdir -p "$GHOSTTYDIR"
	createSymlink "$DOTDIR/ghostty/config" "$GHOSTTYDIR/config"
	echo -e "\e[32mDotfiles ok!\e[0m"
}

function main() {
	clear -x

	local options=(
		"Install basic software (cli tools, go, and lua)"
		"Install OhMyZsh"
		"Install Dotfiles"
		"Install RPM Fusion and RPM Fusion Free"
		"Install Deno"
		"Install Node.js"
		"Install Flatpaks"
	)

	menu() {
		echo "What do you want to do?"
		for i in "${!options[@]}"; do
			local label=" $((i + 1))) ${options[i]}"
			[ "${choices[i]}" ] && echo -e "\e[46m\e[30m+$label\e[0m" || echo -e " $label"
		done
		[[ "$msg" ]] && echo "$msg"
		:
	}

	prompt="Check an option (again to uncheck, ENTER when done): "
	while menu && read -s -n 1 -rp "$prompt" num && [[ "$num" ]]; do
		([[ "$num" != *[![:digit:]]* ]] &&
			((num > 0 && num <= ${#options[@]}))) ||
			{
				msg="Invalid option: $num"
				clear -x
				continue
			}
		((num--))
		msg=""
		[[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
		clear -x
	done
	echo ""

	[ -n "${choices[0]}" ] && installBasicSoftware
	[ -n "${choices[1]}" ] && installOhMyZsh
	[ -n "${choices[2]}" ] && installDotfiles
	[ -n "${choices[3]}" ] && installRPMFusion
	[ -n "${choices[4]}" ] && installDeno
	[ -n "${choices[5]}" ] && installNode
	[ -n "${choices[6]}" ] && installFlatpaks
}

main
