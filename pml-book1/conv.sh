#!/bin/bash
docker run \
  --rm --init -it \
  -v $PWD:/home/marp/app \
  -e LANG=$LANG \
  -e MARP_USER="$(id -u):$(id -g)" \
  marpteam/marp-cli $@

