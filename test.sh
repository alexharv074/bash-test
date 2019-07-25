cat > FILE <<EOF
"location":"<48.777098,9.181301> - 150.0m",
"message":"Hello there!",
"heading": "34",
EOF

placeLocation=myPlaceLocation
vehicleHeading=myVehicleHeading
message='what is 1&2?'

file=FILE

gsed -i -e '/location/c\' -e '"location": "'"$placeLocation"'",' "$file"
gsed -i -e '/heading/c\' -e '"heading": "'"$vehicleHeading"'",' "$file"
gsed -i -e '/message/c\' -e '"message": "'"$message"'",' "$file"
