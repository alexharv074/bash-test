cat > FILE <<EOF
1,    xx,  yy,  zz,
2,    aa,  bb,    ,
3,    cc,  dd,  ee,
4,    ff,  gg,    ,
5,    hh,  ii,    ,
EOF

gawk '
  BEGIN {
    FPAT = "[ ,]+"
  }
  $4 == "" {
    print > "FILE1.csv"
  }
  $4 != "" {
    print > "FILE2.csv"
  }
  ' FILE

cat FILE1.csv
cat FILE2.csv
