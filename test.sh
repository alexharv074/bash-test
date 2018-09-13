while getopts "ab:" opt; do
  case $opt in
  a)
    foo=true
    ;;
  b)
    bar=$OPTARG
    ;;
  esac
done
shift $((OPTIND -1))
echo "You passed $bar to -b, -a is $foo, and then passed $* after that"
