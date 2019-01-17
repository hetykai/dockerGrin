#!/bin/bash
docker pull fullnodes/grin:latest
docker stop grind
docker rm grind
docker volume create grin
docker run -dit --name grind --net=host --restart=always -v grin:/root/.grin fullnodes/grin:latest
mkdir -p ~/.bin
cp $(pwd)/bin/grin* ~/.bin
