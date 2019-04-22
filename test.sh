
string='my\nmulti\nline\nstring\n'

cat > FILE <<EOF
foo
### the first line

abc cba jfkdslfjslkd

### other lines"
EOF

#gsed -e '0,/^###/i\' -e "$string" FILE

gsed -E "0,/###/ i$string" FILE
