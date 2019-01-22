#!/usr/bin/env bash

script_under_test=$(basename $0)

aws() {
  echo "${FUNCNAME[0]} $*" >> commands_log
  case "${FUNCNAME[0]} $*" in
  'aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?contains(Tags[?Key==`aws:cloudformation:stack-name`].Value, `MyStack`)].AutoScalingGroupName --output text')
    cat <<EOF
my-auto-scaling-group-1
my-auto-scaling-group-2
EOF
    ;;
  'aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?AutoScalingGroupName==`my-auto-scaling-group-1`].DesiredCapacity --output text')
    echo 2
    ;;
  'aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?AutoScalingGroupName==`my-auto-scaling-group-2`].DesiredCapacity --output text')
    echo 2
    ;;
  'aws autoscaling set-desired-capacity --auto-scaling-group-name my-auto-scaling-group-1 --desired-capacity 3 --honor-cooldown') true ;;
  'aws autoscaling set-desired-capacity --auto-scaling-group-name my-auto-scaling-group-2 --desired-capacity 3 --honor-cooldown') true ;;
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
aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?contains(Tags[?Key==`aws:cloudformation:stack-name`].Value, `MyStack`)].AutoScalingGroupName --output text
aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?AutoScalingGroupName==`my-auto-scaling-group-1`].DesiredCapacity --output text
aws autoscaling set-desired-capacity --auto-scaling-group-name my-auto-scaling-group-1 --desired-capacity 3 --honor-cooldown
aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?AutoScalingGroupName==`my-auto-scaling-group-1`].DesiredCapacity --output text
aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?AutoScalingGroupName==`my-auto-scaling-group-2`].DesiredCapacity --output text
aws autoscaling set-desired-capacity --auto-scaling-group-name my-auto-scaling-group-2 --desired-capacity 3 --honor-cooldown
aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[?AutoScalingGroupName==`my-auto-scaling-group-2`].DesiredCapacity --output text
EOF

  assertEquals "unexpected sequence of commands issued" \
    "" "$(diff -wu expected_log commands_log)"
}

. shunit2
