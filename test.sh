run() {
  case "$SCRIPT" in
    AlexHarvey) 
      gsed $1 '
        1{
          /999/d
        }
        $!N
        /999/d
        P
        D
        ' FILE
    ;;
    potong)
      gsed -n '
        :a
        $!N
        /\n.*999/ {
          :b
          n
          /999/bb
          ba
        }
        /999/!P
        D
        ' FILE
    ;;
    EdMorton)
      awk '
        $NF == 999 {
          prev = ""
          next
        }
        {
          printf "%s", prev
          prev = $0 ORS
        }
        END {
          printf "%s", prev
        }
        ' FILE
    ;;
  esac
}

test999InFirstLine() {
  cat > FILE <<EOF
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
EOF
  output=$(run)
  assertEquals "SHOULD PRINT
SHOULD PRINT
SHOULD PRINT" "$output"
}

test999InSecondLine() {
  cat > FILE <<EOF
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
EOF
  output=$(run)
  assertEquals "SHOULD PRINT
SHOULD PRINT
SHOULD PRINT" "$output"
}

test999InSecondLastLine() {
  cat > FILE <<EOF
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
EOF
  output=$(run)
  assertEquals "SHOULD PRINT
SHOULD PRINT
SHOULD PRINT" "$output"
}

test999InLastLine() {
  cat > FILE <<EOF
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
EOF
  output=$(run)
  assertEquals "SHOULD PRINT
SHOULD PRINT
SHOULD PRINT" "$output"
}

test999InNoneOfAbove() {
  cat > FILE <<EOF
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD PRINT
EOF
  output=$(run)
  assertEquals "SHOULD PRINT
SHOULD PRINT
SHOULD PRINT
SHOULD PRINT" "$output"
}

test999InThreeLinesInARow() {
  cat > FILE <<EOF
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
SHOULD PRINT
SHOULD NOT PRINT
This is test line 999
This is test line 999
This is test line 999
SHOULD PRINT
SHOULD PRINT
EOF
  output=$(run)
  assertEquals "SHOULD PRINT
SHOULD PRINT
SHOULD PRINT
SHOULD PRINT" "$output"
}

testSample() {
  cat > FILE <<EOF
This is test line 11
This is test line 999
This is test line 12
This is test line 13
This is test line 16
This is test line 999
This is test line 17
This is test line 18
EOF
  output=$(run)
  assertEquals "This is test line 12
This is test line 13
This is test line 17
This is test line 18" "$output"
}

. shunit2
