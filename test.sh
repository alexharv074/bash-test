cat > FILE <<EOF
=======
other
text
===================================
v2.0.0

Added feature 3
Added feature 4
===================================
v1.0.0

Added feature 1
Added feature 2
===================================
EOF

gsed -E '0,/^={35}$/d; //Q' FILE
