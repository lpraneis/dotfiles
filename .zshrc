# Testing
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=/home/logan/.oh-my-zsh
 
path+=('/home/logan/.local/bin')
path+=('/home/logan/go/bin/')
export PATH

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt no_share_history
unsetopt share_history

export EDITOR=nvim

ZSH_THEME="spaceship"
SPACESHIP_NODE_SHOW="false"
SPACESHIP_RUST_SHOW="false"
SPACESHIP_DIR_TRUNC=2
SPACESHIP_EXEC_TIME_ELAPSED=30
SPACESHIP_DOCKER_SHOW="false"


#Disable auto window naming in tmux
DISABLE_AUTO_TITLE=true

# Zsh custom
ZSH_CUSTOM=/home/logan/.oh-my-zsh/custom

# User configuration
DEFAULT_USER='logan'
# prompt_context(){}
umask 026

# USE POSIX time command
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

#OH MY ZSH
plugins=(
  git
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
  vi-mode
  ssh-agent
  )

source $ZSH/oh-my-zsh.sh

# Allow Alt+. to have last command args in vicmd mode
set -o vi
bindkey "^[." insert-last-word
bindkey "^F" autosuggest-accept
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

#source aliases
source ~/dotfiles/aliases.zsh

# source functions
source ~/dotfiles/functions.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
