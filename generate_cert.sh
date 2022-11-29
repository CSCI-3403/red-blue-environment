#!/bin/bash

if [[ $# != 2 ]]; then
    echo "Usage: $0 DOCKER_IMAGE USERNAME"
    exit 1
fi

docker_image=$1
name=$2

docker compose run --rm "$docker_image" easyrsa build-client-full "$name" nopass
docker compose run --rm "$docker_image" ovpn_getclient "$name" > "$name.ovpn"
