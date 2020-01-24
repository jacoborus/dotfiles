jacobo's dotfiles
=================


Dotfiles for Ubuntu with minimal installation


## Basic software:

Development:

```sh
sudo apt install git ssh meld xclip xsel saidar tree silversearcher-ag zsh tmux\
     python-dev python-pip python3-dev python3-pip neovim p7zip-full jq git-extras whois
```

DBs:
```sh
sudo apt install redis mongodb
sudo snap install redis-desktop-manager
```

General:

```sh
sudo apt install vlc inkscape gimp ubuntu-restricted-extras qbittorrent
```


## NeoVim

Install NeoVim PPA:

```
sudo apt-add-repository ppa:neovim-ppa/stable
```

Install vim-plug in neovim (linux)

```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


## Node.js packages

Install nodejs (this: `setup_13.x` will install v13, change it if needed

```sh
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Install Yarn:

```sh
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```

Install global node.js packages:

```sh
sudo npm i -g nodemon standard tern npm-check trash-cli sloc npx pm2
```

## Python utils

Install python packages:

```
sudo pip install cheat && pip2 install neovim && pip3 install neovim
```


## Gnome

### Extensions

- [Dash to panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [Top Panel workspace scroll](https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/)
