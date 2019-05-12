cat > FILE <<EOF
127.0.0.1
127.0.1.1  servername
2.2.2.2  foo
EOF

IP='192.168.1.1'

gsed -E '1h; 1!H; $!d; x; s/(.*)(127\.0\.[^\t ]+)/\1'"$IP"'/' FILE
