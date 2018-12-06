#!/bin/bash
mkdir Rjcms
unzip $1 -d Rjcms
docker build -t apachetom .
docker run -d --name myContainer -p  8000:8080 apachetom
   #! rm -rf Rjcms