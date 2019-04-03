setUp() {
  cat > /tmp/before <<EOF
aaa
bbb
ccc
bbb
ccc
eee
EOF
  cat > /tmp/expected <<EOF
aaa
bbb
ccc
bbb
ccc
ddd
eee
EOF
}

script_under_test1() {
  cat <<EOF
function! AddLine()
  call search("bbb")
  call search("bbb")
  let l:foundline = search("ccc")
  call append(l:foundline, "ddd")
  wq!
endfunction
EOF
}

script_under_test2() {
  cat <<EOF
function! AddLine()
  normal /bbbn/cccoddd
  wq!
endfunction
EOF
}

testIt1() {
  script_under_test1 > /tmp/script.vim
  vim -u /tmp/script.vim -c 'call AddLine()' /tmp/before
  assertEquals "" "$(diff -u /tmp/expected /tmp/before)"
}

testIt2() {
  script_under_test2 > /tmp/script.vim
  vim -u /tmp/script.vim -c 'call AddLine()' /tmp/before
  assertEquals "" "$(diff -u /tmp/expected /tmp/before)"
}

. shunit2
