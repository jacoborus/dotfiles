jacobo's dotfiles
=================

Dotfiles for Ubuntu 16.10

Install NeoVim PPA:

```
sudo apt-add-repository ppa:neovim-ppa/stable
```

**Install software:**

Development:

```sh
sudo apt install git ssh meld xclip xsel saidar tree silversearcher-ag zsh tmux\
     highlight python-dev python-pip python3-dev python3-pip neovim p7zip-full jq\
     git-extras redis mongodb whois
```

Other:

```sh
sudo apt install vlc inkscape gimp ubuntu-restricted-extras qbittorrent
```

Install vim-plug in neovim (linux)

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

```
chmod +x bootstrap.sh
```

Install global node.js packages:

```
sudo npm i -g nodemon standard tern npm-check trash-cli sloc npx pm2
```

Install python packages:

```
sudo pip install cheat && pip2 install neovim && pip3 install neovim
```
