#!/bin/bash

declare -a arr=(node_modules/* package-lock.json bundle.js.map)

function deploy(){
    echo aws s3 rm s3://bucketname --profile Administrator --recursive
    echo aws s3 sync ./ s3://bucketname --profile Administrator \
      $(for x in "${arr[@]}" ; do echo "--exclude=$x " ; done)
}

deploy
