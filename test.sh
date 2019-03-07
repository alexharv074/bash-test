aws iam list-users --output text > users.txt
cut -f6 users.txt | while read user ; do
  (echo $user ; aws iam list-groups-for-user \
      --user-name $user \
      --output text) | paste - - > groups.txt
done
join -1 6 -2 1 users.txt groups.txt
