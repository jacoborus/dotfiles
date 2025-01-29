# PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/var/lib/flatpak/exports/share:$PATH"
export PATH="$HOME/.local/share/flatpak/exports/share:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# FZF
export FZF_DEFAULT_OPTS="--reverse --preview 'highlight -O ansi -l {}'"
# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# Go
export PATH="$HOME/go/bin:$PATH"
export GOPATH="$HOME/go"
# Zig
export PATH="$HOME/.apps/zig:$PATH"
# Node
export NPM_PACKAGES=$HOME/.npm-packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Secrets
if [ -e "$HOME/dotfiles/secrets.sh" ] || [ -L "$HOME/dotfiles/secrets.sh" ]; then
	source "$HOME/dotfiles/secrets.sh"
fi
# docker
export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock

export PATH="/opt/nvim-linux64/bin:$PATH"
