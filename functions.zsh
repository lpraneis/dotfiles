function pdfextract()
{
  # this function uses 3 arguments:
  #     $1 is the first page of the range to extract
  #     $2 is the last page of the range to extract
  #     $3 is the input file
  #     output file will be named "inputfile_pXX-pYY.pdf"
  if [ $# -lt 3 ]; then
    echo "USAGE"
    echo "pdfextract first_page last_page input_file [output_file]"
  elif [ $# -eq 3 ]; then
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
      -dFirstPage=${1} \
      -dLastPage=${2} \
      -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
      ${3}
        else 
          gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
            -dFirstPage=${1} \
            -dLastPage=${2} \
            -sOutputFile=${4} \
            ${3}
  fi
}
function mkcd() { mkdir "$1"; cd "$1"; }
function cs() { dir=$(find /home/logan/currTerm/ -maxdepth 3 -type d| fzf +m) && cd "$dir"}
function py() { env=$(find /home/logan/python-virtual-environments -maxdepth 1 -type d | fzf +m) &&
    source "$env/bin/activate"}
