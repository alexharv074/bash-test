cat > FILE <<EOF
127.0.0.1    localhost
EOF

sed -i.bak -e 's,\(127\.0\.0\.1[[:space:]]*localhost\),\1aa,' FILE
cat FILE
