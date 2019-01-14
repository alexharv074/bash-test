#!/usr/bin/env bash

script_under_test=$(basename $0)

aws() {
  echo "${FUNCNAME[0]} $*" >> commands_log
  case "${FUNCNAME[0]} $*" in
  'aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?contains(Tags[?Key==`aws:cloudformation:stack-name`].Value, `MyStack`)].AutoScalingGroupName')
    cat <<EOF
[
    "my-auto-scaling-group-1",
    "my-auto-scaling-group-2"
]
EOF
    ;;
  *)
    echo "No responses for: aws $*"
    ;;
  esac
}

tearDown() {
  rm -f commands_log
}

testScript() {
  echo "MyStack" | . $script_under_test

  cat > expected_log <<'EOF'
aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?contains(Tags[?Key==`aws:cloudformation:stack-name`].Value, `MyStack`)].AutoScalingGroupName
EOF

  assertEquals "unexpected sequence of commands issued" \
    "" "$(diff -wu expected_log commands_log)"
}

. shunit2
