# starship
eval "$(starship init zsh)"
# history file config
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt INC_APPEND_HISTORY # append into history file
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS  ## Delete empty lines from history file
setopt HIST_NO_STORE  ## Do not add history and fc commands to the history

alias ls="ls --color=always"
alias l="ls --color=always -lhA"
alias ll="ls --color=always -lh"
alias vim="nvim"
alias lspconfig="nvim ~/tools/dotfiles/nvim/lua/lsp.lua"
alias nvimconfig="nvim ~/tools/dotfiles/nvim/init.lua"

autoload -Uz compinit && compinit

. "$HOME/.cargo/env"
alias cgi="curl https://www.cloudflare.com/cdn-cgi/trace"
alias cat=bat

# Grim screenshotting
export GRIM_DEFAULT_DIR="$HOME/pictures"
function screenshot() {
	geo=$(slurp)
	grim -g "$geo"
	echo "Screenshot saved in $GRIM_DEFAULT_DIR"
}


export PATH="$PATH:$HOME/bin"

# Hacks for screen sharing on sway wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add ssh agent
[ -z "$SSH_AUTH_SOCK" ] && eval `ssh-agent`

