cat > FILE <<EOF
#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[multilib]
#Include = /etc/pacman.d/mirrorlist
EOF

gsed -i '
  /\[multilib]/ {
    n
    s/^#//
  }
  ' FILE

#gsed -i '/class A/,/path/{s!path=.*!path='"'/x/y/z'"'!}' FILE
