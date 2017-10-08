#!/bin/bash

set -ex

sed "s|VERSION|$1|" Dockerfile.tpl > Dockerfile
docker build . -t eventuateio-local-kafka_release --squash

if [[ -n $3 ]] && [[ -n $4 ]]; then
    docker login -u $3 -p $4

    docker tag eventuateio-local-kafka_release $2/eventuateio-local-kafka:latest
    docker tag eventuateio-local-kafka_release $2/eventuateio-local-kafka:$1
    docker push $2/eventuateio-local-kafka

    # clean up
    docker rmi $2/eventuateio-local-kafka:latest
    docker rmi $2/eventuateio-local-kafka:$1
    docker rmi eventuateio-local-kafka_release
    docker images | awk '/^<none>/{ print $3 }' | xargs docker rmi --force
fi

set +ex
