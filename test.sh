cat > FILE <<EOF
the quick brown
 fox jumped
 "over
   the
... lazy dog
EOF

echo "input"
cat FILE

printf "\ntest 1\n"
gsed -E 's/\b(.)/\u\1/' FILE

printf "\ntest 2\n"
cp FILE FILE1
vim -c 'exe "%normal 0gUwl$" | wq!' FILE1 ; cat FILE1

printf "\ntest 3\n"
vim -c 'execute "%s/\\<\\(.\\)/\\u\\1/" | wq!' FILE ; cat FILE
