array=(www.google.com www.facebook.com www.linkedin.com www.stackoverflow.com)
fastest_response=2147483647 # largest possible integer
for site in ${array[*]}
do
  this_response=`ping -c 4 "$site" | awk 'END { split($4,rt,"/") ; print rt[1] }'`
  if (( $(bc -l <<< "$this_response < $fastest_response") )) ; then
    fastest_response=$this_response
    fastest_site=$site
  fi
  echo "Got $this_response for $site ; fastest so far $fastest_site"
done
echo $fastest_site
