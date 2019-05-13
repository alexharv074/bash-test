cat > FILE <<EOF
Somename of someone                                   1234 7894
Even some more name                                   2345 5343
Even more of the same                                 6572 6456
I am a customer                                       1324 7894
I am another customer                                 5612 3657
Also I am a customer and I am number Three            9631 7411
And I am number four and not the latest one in list   8529 9369
And here I am                                         4567 9876
EOF

gawk '
  BEGIN {
    FIELDWIDTHS = "54 5 5"; OFS = ","
  }
  {
    for (f=1; f<=NF; f++)
      gsub(/ +$/, "", $f)
    print $1, $2, $3
  }
  ' FILE
