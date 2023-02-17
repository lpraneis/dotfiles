# starship
eval "$(starship init zsh)"

# history file config
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

fpath=(~/tools/completions $fpath)
autoload -Uz compinit && compinit

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

# Source some device-specific options
[ -f "$HOME/.zshrc-specific" ] && source ~/.zshrc-specific

. "$HOME/.cargo/env"
alias cat=bat
alias nfzf="fzf | xargs -o nvim"
alias ls=exa

# Use fd by default ( with colors ) 
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

# Grim screenshotting
function screenshot() {
	slurp | grim -g - - | wl-copy
	echo "Screenshot saved to clipboard"
}

# Clean up branches that are deleted from remote
function cleanup-local-branches() {
    branches=$(git branch -vv | grep ': gone]'| grep -v '\*'| awk '{print $1; }')
		echo "Will delete:\n$branches\n"
		read "choice?Ok ? (y/N) "
		case "$choice" in
			y|Y ) echo $branches | xargs -r git branch -D;;
			n|N|* ) echo "Not deleting branches";;
		esac
}

export PATH="$PATH:$HOME/bin"
export EDITOR="nvim"
bindkey -e

# Go path
export PATH="$PATH:/usr/local/go/bin"

# Hacks for screen sharing on sway wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add ssh agent
[ -z "$SSH_AUTH_SOCK" ] && eval `ssh-agent`


# Created by `userpath` on 2022-07-12 14:14:25
export PATH="$PATH:/home/lpraneis/.local/bin"
