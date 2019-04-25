cat FILE | sed '/./!d' | awk '
  BEGIN {
    d[0] = ""; d[1] = ""
  }
  {
    n = NR % 2
    if (d[n] == "")
      d[n] = $0
    else {
      print d[n] "," $0
      d[n] = ""
    }
  }
  END {
    if (d[1] != "") print d[1]
    if (d[0] != "") print d[0]
  }
  '
