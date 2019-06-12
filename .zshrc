# Testing
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/logan/.oh-my-zsh

  #PATH for go
  # path+=('/usr/local/go/bin:/home/logan/bin:/home/logan/bin/bin')
 
  path+=('/usr/local/texlive/2018/bin/x86_64-linux')
  path+=('/home/logan/.local/bin')
  path+=('.')
  path+=('/home/logan/go/bin/')
  path+=('/home/logan/.npm-global/bin')
  export PATH

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"
SPACESHIP_NODE_SHOW="false"
SPACESHIP_DIR_TRUNC=2
SPACESHIP_EXEC_TIME_ELAPSED=30
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
 ZSH_CUSTOM=/home/logan/.oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
  vi-mode
  ssh-agent
)

#   Fuzzy Finding!  #
#####################

#Disable auto window naming in tmux
DISABLE_AUTO_TITLE=true



source $ZSH/oh-my-zsh.sh

# User configuration
DEFAULT_USER='logan'
prompt_context(){}
umask 026


# USE POSIX time command
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'
#autosuggestions configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# FUNCTIONS

function pdfextract()
{
 # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    if [ $# -lt 3 ]; then
      echo "USAGE"
      echo "pdfextract first_page last_page input_file"
    else
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
    fi
     }

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vi="nvim"
alias normps="$HOME/bin/normps.sh"
alias prog="git log -- ."
alias ghidra="/home/logan/apps/ghidra_9.0.1/ghidraRun"
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias sage="/home/logan/apps/SageMath/sage"
alias pia="/opt/piavpn/bin/pia-client"
alias cat="bat"
cs() { dir=$(find /home/logan/currTerm/ -maxdepth 3 -type d| fzf +m) && cd "$dir"}
py() { env=$(find /home/logan/python-virtual-environments -maxdepth 1 -type d | fzf +m) && 
   source "$env/bin/activate"}


# alias ohmyzsh="mate ~/.oh-my-zsh"

# OPAM configuration
. /home/logan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
alias config='/usr/bin/git --git-dir=/home/logan/.cfg/ --work-tree=/home/logan'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
