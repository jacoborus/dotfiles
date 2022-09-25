#!/bin/bash

files=".bashrc .tmux.conf .zshrc" # list of files/folders to symlink in homedir
vimfiles="init.vim coc-settings.json general.vim plugin.vim plug.vim status.vim" # list of files/folders to symlink in homedir
viminitfiles="plug.vim general.vim plugins.vim status.vim" # list of files/folders to symlink in homedir

dotdir=$(dirname "$1") # dotfiles directory
today="`date +%Y-%m-%d_%H-%M-%S`"
backupfolder="$HOME/dotfiles_old/$today"
vimdir="$HOME/.config/nvim"
dotdir=`readlink -f $dotdir`

function main() {
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

main
