alias vi="nvim"
alias normps="$HOME/bin/normps.sh"
alias prog="git log -- ."
alias ghidra="/home/logan/apps/ghidra_9.1.2_PUBLIC/ghidraRun"
alias sage="/home/logan/apps/SageMath/sage"
alias cat="bat"
alias ls="ls --color=tty"
alias umnvpn="/opt/cisco/anyconnect/bin/vpnui"
alias dc="sudo docker-compose"
alias loadalgo="sudo /home/logan/Documents/tech/vpn/load-algo.sh"
alias unloadalgo="sudo /home/logan/Documents/tech/vpn/unload-algo.sh"

cs() { dir=$(find /home/logan/currTerm/ -maxdepth 3 -type d| fzf +m) && cd "$dir"}
py() { env=$(find /home/logan/python-virtual-environments -maxdepth 1 -type d | fzf +m) &&
    source "$env/bin/activate"}

mkcd() { mkdir "$1"; cd "$1"; }
