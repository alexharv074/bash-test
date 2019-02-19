find src/ -exec grep -R 'actions/Auth' {} \; | awk '{split($0,a,":");print a[1]}' | while IFS= read -r line; do echo $line; done
