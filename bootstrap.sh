#!/bin/bash

# Variables

dir=$(dirname "$0") # dotfiles directory
files=".bashrc .tmux.conf .zshrc" # list of files/folders to symlink in homedir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
cd ~
for file in $files; do
  filename="${dir}/${file}"
  rm -f "$file"
  echo "Creating symlink to $file"
  ln -s "$filename" .
done

echo "Creating symlink for neovim rc file"
cd ~/.config/nvim/
vimrcorigin="${dir}/init.vim"
rm -f init.vim
ln -s "$vimrcorigin" .
cd "$dir"

