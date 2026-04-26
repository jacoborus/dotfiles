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
