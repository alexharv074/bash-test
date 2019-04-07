#!/usr/bin/env bash

data="aaa
bbb
PATTERN1
foo
bar
baz
qux
PATTERN2
ccc
ddd"

expected="aaa
bbb
PATTERN1
bar
baz
foo
qux
PATTERN2
ccc
ddd"

testIt1() { response=$(gawk '/^PATTERN1/ {f=1;delete a}
     /^PATTERN2/ {f=0; n=asort(a); for (i=1;i<=n;i++) print a[i]}
     !f
     f{a[$0]=$0}' <<< "$data")
  assertEquals "$expected" "$response"
}

testIt2() {
  response=$(gawk '/^PATTERN1/ {f=1} /^PATTERN2/ {f=0; n=asort(a); for (i=1;i<=n;i++) print a[i]} !f; f{a[$0]=$0}' <<< "$data")
  assertEquals "$expected" "$response"
}

testIt3() {
  response=$(gawk -v p=1 '
    /^PATTERN2/ {          # when we we see the 2nd marker:

        # close the "write" end of the pipe to sort. Then sort will know it
        # has all the data and it can begin sorting
        close("sort", "to");

        # then sort will print out the sorted results, so read and print that
        while (("sort" |& getline line) >0) print line 

        # and turn the boolean back to true
        p=1
    }
    p  {print}             # if p is true, print the line
    !p {print |& "sort"}   # if p is false, send the line to `sort`
    /^PATTERN1/ {p=0}      # when we see the first marker, turn off printing
    ' <<< "$data")
  assertEquals "$expected" "$response"
}

testIt4() {
  response=$(
    sed '1,/^PATTERN1$/!d' <<< "$data"
    sed '/^PATTERN1$/,/^PATTERN2$/!d' <<< "$data" | head -1 | tail -n +2 | sort
    sed '/^PATTERN2$/,$!d' <<< "$data"
  )
  assertEquals "$expected" "$response"
}

testIt5() {
  response=$(
    gsed -n '1,/PATTERN1/p' <<< "$data"
    gsed   '1,/PATTERN1/d;/PATTERN2/Q' <<< "$data" | sort
    gsed -n '/PATTERN2/,$p' <<< "$data"
  )
  assertEquals "$expected" "$response"
}

. shunit2
