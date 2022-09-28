#!/bin/bash

# list of files to symlink and backup in homedir
FILES=".bashrc .tmux.conf .zshrc"
# list of files to backup in vim directory
VIMFILES="init.vim coc-settings.json general.vim plugin.vim plug.vim status.vim"
# list of files to symlink in vim directory
VIMINITFILES="plug.vim general.vim plugins.vim status.vim"

DOTDIR=`readlink -f $(dirname "$0")` # dotfiles directory
TODAY="`date +%Y-%m-%d_%H-%M-%S`"
BACKUPFOLDER="$HOME/dotfiles_old/$TODAY"
VIMDIR="$HOME/.config/nvim"
THEMESFOLDER=$HOME/.oh-my-zsh/themes

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

function createBackup() {
  local ORIGIN="$1/$2"
  if [ -e $ORIGIN ]; then
    local DESTINATION="$BACKUPFOLDER/$2"
    echo "'$ORIGIN' => '$DESTINATION'"
    mkdir -p $BACKUPFOLDER
    mv $ORIGIN $DESTINATION
    [ -e $ORIGIN ] && rm -y $ORIGIN
  fi
}

function createSymlink() {
  local ORIGIN="$2/$1"
  local DESTINATION="$3"
  ln -s -v $ORIGIN $DESTINATION
}

function installVimplug() {
  echo -e "\e[34mInstalling vim-plug\e[0m"
  sh -c 'curl -fLo $HOME/.config/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
    && echo 'vim-plug ok'
}

function installOhMyZsh() {
  echo -e "\e[34mInstalling ZSH plugin manager (OhMyZsh)...\e[0m"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && echo 'ok'
}

function installDotfiles() {
  # Move old files to backup folder
  echo -e "\e[34mMoving old files to backup folder...\e[0m"
  for file in $FILES; do
    createBackup $HOME $file
  done
  for file in $VIMFILES; do
    createBackup $VIMDIR $file
  done
  createBackup $THEMESFOLDER adesis.zsh-theme
  createBackup $THEMESFOLDER rush.zsh-theme

  # Create sylinks
  echo -e "\e[34mCreating symlinks...\e[0m"

  createSymlink '.bashrc' $DOTDIR/sh $HOME
  createSymlink '.zshrc' $DOTDIR/sh $HOME
  createSymlink '.tmux.conf' $DOTDIR/tmux $HOME
  createSymlink 'adesis.zsh-theme' $DOTDIR/sh $THEMESFOLDER
  createSymlink 'rush.zsh-theme' $DOTDIR/sh $THEMESFOLDER

  mkdir -p $VIMDIR
  createSymlink 'coc-settings.json' $DOTDIR/vim $VIMDIR

  # Generate init.vim file
  echo -e "\e[34mCreating init.vim file...\e[0m"
  local INITVIM=""
  for file in $VIMINITFILES; do
    INITVIM="$INITVIM\nso $DOTDIR/vim/$file"
  done
  echo -e "$INITVIM" > $VIMDIR/init.vim
}

function installBasicSoftware() {
  echo -e "\e[34mInstalling basic software\e[0m"
  if command_exists apt; then
    echo "apt found! installing basic software... not. TODO"
    exit
  elif command_exists dnf; then
    echo "dnf found! installing basic software... not. TODO"
    exit
  else
    echo 'no apt or dnf found. Aborting...'
    exit
  fi
}

function installFedoraDocker() {
  if command_exists docker; then
    echo "Docker is already installed. Skipping..."
    exit
  else
    echo -e "\e[34mInstalling docker\e[0m"
    sh -c "$(curl -fsSL https://get.docker.com)" \
      && sudo systemctl start docker
  fi
}

function main() {
  clear -x

  local options=(
    "Install NeoVim plugin manager (vim-plug)"
    "Install ZSH plugin manager (OhMyZsh)"
    "Install Dotfiles"
    "Install basic software"
    "(Only Fedora) Install Docker"
  )

  menu() {
    echo "What do you want to do?"
    for i in ${!options[@]}; do
      local label=" $((i+1))) ${options[i]}"
      [ "${choices[i]}" ] && echo -e "\e[46m\e[30m+$label\e[0m" || echo -e " $label"
    done
    [[ "$msg" ]] && echo "$msg"; :
  }

  prompt="Check an option (again to uncheck, ENTER when done): "
  while menu && read -s -n 1 -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; clear -x; continue; }
    ((num--)); msg=""
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
    clear -x
  done
  echo ""

  [ -n "${choices[0]}" ] && installVimplug
  [ -n "${choices[1]}" ] && installOhMyZsh
  [ -n "${choices[2]}" ] && installDotfiles
  [ -n "${choices[3]}" ] && installBasicSoftware
  [ -n "${choices[4]}" ] && installFedoraDocker
}

main
