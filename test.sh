users=$(aws iam list-users \
  --query 'Users[].UserName' \
  --output text
)
for user in $users ; do
  groups=$(aws iam list-groups-for-user \
      --user-name $user \
      --query 'Groups[].GroupName' \
      --output text \
    | paste -s -d, -
  )
  printf "%s\t%s\n" $user $groups
done
