#!/bin/bash

# list of files to symlink and backup in homedir
files=".bashrc .tmux.conf .zshrc"
# list of files to backup in vim directory
vimfiles="init.vim coc-settings.json general.vim plugin.vim plug.vim status.vim"
# list of files to symlink in vim directory
viminitfiles="plug.vim general.vim plugins.vim status.vim"

dotdir=`readlink -f $(dirname "$0")` # dotfiles directory
today="`date +%Y-%m-%d_%H-%M-%S`"
backupfolder="$HOME/dotfiles_old/$today"
vimdir="$HOME/.config/nvim"

function installDotfiles() {
  # Move old files to backup folder
  echo -e "\e[34mMoving old files to backup folder...\e[0m"
  for file in $files; do
    createBackup $HOME $file
  done
  for file in $vimfiles; do
    createBackup $vimdir $file
  done

  # Create sylinks
  echo -e "\e[34mCreating symlinks...\e[0m"

  createSymlink '.bashrc' $dotdir/sh $HOME
  createSymlink '.zshrc' $dotdir/sh $HOME
  createSymlink '.tmux.conf' $dotdir/tmux $HOME

  mkdir -p $vimdir
  createSymlink 'coc-settings.json' $dotdir/vim $vimdir

  # Generate init.vim file
  echo -e "\e[34mCreating init.vim file...\e[0m"
  initvim=""
  for file in $viminitfiles; do
    initvim="$initvim\nso $dotdir/vim/$file"
  done
  echo -e "$initvim" > $vimdir/init.vim
}

function createBackup() {
  origin="$1/$2"
  if [ -e $origin -o -L $origin ]; then
    destination="$backupfolder/$2"
    echo "'$origin' => '$destination'"
    mkdir -p $backupfolder
    mv $origin $destination
    [ -e $origin ] && rm -y $origin
  fi
}

function createSymlink() {
  origin="$2/$1"
  destination="$3"
  ln -s -v $origin $destination
}

function installGitZshCompletion() {
  echo -e "\e[34mInstalling git zsh completion\e[0m"
  mkdir -p $HOME/.zsh
  curl -o $HOME/.zsh/git-completion.zsh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh \
    && echo 'ok'
}

function installAntigen() {
  echo -e "\e[34mInstalling ZSH plugin manager (Antigen)...\e[0m"
  mkdir -p $HOME/.zsh
  curl -L git.io/antigen > $HOME/.zsh/antigen.zsh \
    && echo 'ok'
}

function installVimplug() {
  echo -e "\e[34mInstalling vim-plug\e[0m"
  sh -c 'curl -fLo $HOME/.config/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
    && echo 'vim-plug ok'
}

function installBasicSoftware() {
  echo -e "\e[34mInstalling basic software\e[0m"
  if command -v apt &> /dev/null; then
    echo "apt found! installing basic software... not. TODO"
    exit
  elif command -v dnf &> /dev/null; then
    echo "dnf found! installing basic software... not. TODO"
    exit
  else
    echo 'no apt or dnf found. Aborting...'
    exit
  fi
}

function main() {
  clear -x

  options=(
    "Install NeoVim plugin manager (vim-plug)"
    "Install ZSH plugin manager (Antigen)"
    "Install ZSH Git completion"
    "Install Dotfiles"
    "Install basic software"
  )

  menu() {
    echo "What do you want to do?"
    for i in ${!options[@]}; do
      label=" $((i+1))) ${options[i]}"
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
  [ -n "${choices[1]}" ] && installAntigen
  [ -n "${choices[2]}" ] && installGitZshCompletion
  [ -n "${choices[3]}" ] && installDotfiles
  [ -n "${choices[4]}" ] && installBasicSoftware
}

main
