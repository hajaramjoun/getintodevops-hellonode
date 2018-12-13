#!/bin/bash
rm -rf Rjcms
docker stop $1
docker rm $1