cat > FILE <<EOF
 1556113878,60662402644292
 1554090396,59547403093308
EOF

ruby -F, -ane '
  print [Time.at($F[0].to_i).strftime("%Y-%m"), $F[1]].join(",")' FILE
