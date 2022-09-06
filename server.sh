#!/bin/bash
docker run \
  --rm --init -it \
  -v $PWD:/home/marp/app \
  -e LANG=$LANG \
  -e MARP_USER="$(id -u):$(id -g)" \
  -p 8080:8080 -p 37717:37717 \
  marpteam/marp-cli -s .

