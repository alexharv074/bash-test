echo -n 'Enter Name Where Scaling Groups will be updated: "Default Stack" = ' -e -i 'Test ' ; read stackname

scalegroups=($(aws autoscaling describe-auto-scaling-groups \
  --query 'AutoScalingGroups[?contains(Tags[?Key==`aws:cloudformation:stack-name`].Value, `'$stackname'`)].AutoScalingGroupName' \
  --output text))

echo "Total Stacks Found :" ${scalegroups[*]}

for group in "${scalegroups[@]//,/}"
do 
  echo "Processing group: $group"

  currentcapacity=$(aws autoscaling describe-auto-scaling-groups \
    --query 'AutoScalingGroups[?AutoScalingGroupName==`'$group'`].DesiredCapacity' \
    --output text)

  aws autoscaling set-desired-capacity \
    --auto-scaling-group-name $group \
    --desired-capacity $((currentcapacity + 1)) \
    --honor-cooldown

  latestcapacity=$(aws autoscaling describe-auto-scaling-groups \
    --query 'AutoScalingGroups[?AutoScalingGroupName==`'$group'`].DesiredCapacity' \
    --output text)

  echo "Latest Capacity = " $latestcapacity
done
