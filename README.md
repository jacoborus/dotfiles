jacobo's dotfiles
=================


Dotfiles for Ubuntu


## Basic software:

Development:

```sh
sudo apt install git ssh meld xclip xsel saidar tree silversearcher-ag zsh tmux\
     highlight python-dev python-pip python3-dev python3-pip neovim p7zip-full jq\
     git-extras redis mongodb whois
```

Other:

```sh
sudo apt install vlc inkscape gimp ubuntu-restricted-extras qbittorrent &&\
sudo snap install redis-desktop-manager
```

## NeoVim

Install NeoVim PPA:

```
sudo apt-add-repository ppa:neovim-ppa/stable
```

Install vim-plug in neovim (linux)

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

```
chmod +x bootstrap.sh
```

## Node.js packages

Install global node.js packages:

```
sudo npm i -g nodemon standard tern npm-check trash-cli sloc npx pm2
```

## Python utils

Install python packages:

```
sudo pip install cheat && pip2 install neovim && pip3 install neovim
```


## Gnome

### Theme and icons

[PopOS! gtk theme](https://github.com/pop-os/gtk-theme)
[PopOS! icon theme](https://github.com/pop-os/icon-theme)


```sh
sudo add-apt-repository ppa:system76/pop
sudo apt update
sudo apt install pop-theme
```

### Extensions

- [Dash to panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [Top Panel workspace scroll](https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/)
