setUp() {
  data="aaa
PAT1
bbb
ccc
ddd
PAT2
eee
PAT1
2
46
PAT2
xyz"

  expected="bbb
ccc
ddd"
}

testLinkedNotApplicableSolution1() {
  actual=$(gsed -n '/PAT1/,/PAT2/{/PAT1/!{/PAT2/!p}}' <<< $data)
  assertNotEquals "$expected" "$actual"
}

testLinkedNotApplicableSolution2() {
  actual=$(gsed -n '/PAT1/,/PAT2/{//!p}' <<< $data)
  assertNotEquals "$expected" "$actual"
}

testLinkedNotApplicableSolution3() {
  actual=$(gsed -n '/PAT1/,/PAT2/p' <<< $data)
  assertNotEquals "$expected" "$actual"
}

testLinkedNotApplicableSolution4() {
  actual=$(gsed -n '/PAT1/,/PAT2/{/PAT2/!p}' <<< $data)
  assertNotEquals "$expected" "$actual"
}

testIniansIncorrectSolution1InChat() {
  actual=$(awk '/PAT1/{flag=1;next}/PAT2/{flag=0}flag' <<< $data)
  assertNotEquals "$expected" "$actual"
}

testIniansIncorrectSolution2InChat() {
  actual=$(gsed -n '/PAT1/,/PAT2/{//!p}' <<< $data)
  assertNotEquals "$expected" "$actual"
}

testJamesBrownsCorrectSolutionInChat() {
  actual=$(awk '/PAT1/{f=1;next}/PAT2/{exit}f' <<< $data)
  assertEquals "$expected" "$actual"
}

testAbdansSolution() {
  actual=$(gsed -nE '/PAT1/,/PAT2/{:s n;/PAT2/{q};p;bs}' <<< $data)
  assertEquals "$expected" "$actual"
}

testMyOwnCorrectSolution() {
  actual=$(gsed '0,/PAT1/d;/PAT2/Q' <<< $data)
  assertEquals "$expected" "$actual"
}

. shunit2
