jacobo's dotfiles
=================


Dotfiles for Ubuntu with minimal installation


## Basic software:

Development:

```sh
sudo apt install git ssh meld xclip xsel saidar tree silversearcher-ag zsh tmux curl\
      python3-pip neovim p7zip-full jq git-extras whois
```

DBs:
```sh
sudo apt install redis mongodb
sudo snap install redis-desktop-manager
```

General:

```sh
sudo apt install vlc inkscape gimp ubuntu-restricted-extras qbittorrent gnome-sushi gnome-tweak-tool baobab
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

Install nodejs

```sh
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Install global node.js packages:

```sh
sudo npm i -g npm-check trash-cli sloc
```

## Gnome Extensions

- [Dash to panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [Top Panel workspace scroll](https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/)
- [Impatience](https://extensions.gnome.org/extension/277/impatience/)
- [Horizontal workspaces](https://extensions.gnome.org/extension/2141/horizontal-workspaces/)
- [Arc menu](https://extensions.gnome.org/extension/1228/arc-menu/)
- [Sound Input & Output Device Chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
- [Bluetooth quick connect](https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/)
