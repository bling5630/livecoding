#!/bin/bash

#
# this script automates the docker build process
#
IMAGE_NAME=mgreenly/hello-world

#
# make sure the base is current
#
docker pull debian:latest

#
# rebuild the application
#
debian-stack build --force-dirty

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" $IMAGE_NAME | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" $IMAGE_NAME | grep latest | cut -f1 -d:)

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build -f Dockerfile.debian -t $IMAGE_NAME:$newtag .
docker tag $IMAGE_NAME:"$newtag" $IMAGE_NAME:latest

if [[ -n "$oldtag" ]]; then
  docker rmi $IMAGE_NAME:$oldtag
fi

#
# upload the new latest
#
#docker push hello-world:latest
