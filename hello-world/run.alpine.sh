#!/bin/bash

#
# immediately exit if we access any unset variables
#
set -u

#
# pass all the necessary environment varialbes and any
# command line arguments to the container and run it
#
docker run --rm -it \
  -e "EXAMPLE=" \
  --name hello-world \
  mgreenly/hello-world:latest \
  hello-world $@
