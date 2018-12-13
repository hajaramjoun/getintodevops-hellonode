#!/bin/bash

[ ! -d Rjcms ] && mkdir -p Rjcms
unzip $1 -d Rjcms

 if [ -z "$(ls -A Rjcms)" ]; then
   echo "Empty"
else
   echo "Not Empty"
docker build -t apachetom .
docker run -d --name $2 -p  8000:8080 apachetom
 #! rm -rf Rjcms
fi
