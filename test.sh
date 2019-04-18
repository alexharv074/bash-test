data="xx
xx
PATTERN1
c
a
PATTERN2
yy
yy"

gsed -n '
  0,/PATTERN1/p
  /PATTERN1/,/PATTERN2/H
  /PATTERN2/ {
    g;s/\nPATTERN1\n\(.*\)\n\(PATTERN2.*\)/echo "\1" | sort;echo "\2"/e
  }
  /PATTERN2/,$p' <<< $data
