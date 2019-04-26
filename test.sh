cat > FILE <<EOF
word1 word2 word3 word4
word4 word5 word6 word7
word6 word7 word8 word9
word9 word6 word8 word3
EOF

awk '
# script.awk

NR > 1 {
  split(last, last_ar)
  split($0, curr_ar)

  delete found          # Count how many unique occurrences
  for (i in curr_ar)    # of words are seen.
    for (j in last_ar)
      if (last_ar[j] == curr_ar[i])
        found[curr_ar[i]]++

  if (length(found) >= 3) print
}
{
  last = $0
}
' < FILE
