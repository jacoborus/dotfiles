#!/bin/bash

# Variables

dir=$(dirname "$0") # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory
files=".bashrc .tmux.conf .zshrc" # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd "$dir"
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    mv ~/"$file" ~/dotfiles_old/
    echo "Creating symlink to $file"
    ln -s "$dir"/"$file" ~/"$file"
done

echo "Creating symlink for neovim rc file"
ln -s "$dir"/init.vim ~/.config/nvim/init.vim

