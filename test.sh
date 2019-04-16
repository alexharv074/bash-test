data() {
  cat <<EOF
set nat source rule 39 source address '10.112.140.155/32'  
set nat source rule 1008 source address '10.112.140.155/32'  
set nat source rule 1010 source address '10.112.140.155/32'  
set nat source rule 1036 destination address '10.44.68.252/32'  
set nat source rule 1037 destination address '10.44.68.252/32'  
set nat source rule 1099 source address '10.112.140.155/32'  
set nat source rule 1104 source address '10.112.140.155/32'  
set nat source rule 1515 destination address '10.44.68.252/32'  
set nat source rule 1515 source address '10.112.140.155/32'  
set nat source rule 1516 destination address '10.44.68.252/32'  
set nat source rule 1517 source address '10.112.140.155/32'  
set nat source rule 1520 source address '10.112.140.155/32'
EOF
}

data | awk -v sq="'" -v src=10.112.140.155 -v dst=10.44.68.252 '
  BEGIN {
    s_regex = sq src "/"; d_regex = sq dst "/"
  }
  /source address/   &&    $8 ~ s_regex {s[si] = $5; si++}
  /destination address/ && $8 ~ d_regex {d[di] = $5; di++}
  END {
    for (i in s) for (j in d) if (s[i] == d[j]) {print s[i]}
  }
  '
#awk -v src=10.44.68.252 -v dst=10.112.140.155 '
#  BEGIN {xi=0; yi=0}
#  /source address/      && $8 ~ src {x[xi] = $5; xi++}
#  /destination address/ && $8 ~ dst {y[yi] = $5; yi++}
#  END {
#    for (i in x) {for (j in y) if (x[i] == y[j]) {print x[i]; exit}}
#  }
#  ' <<< "$data"
