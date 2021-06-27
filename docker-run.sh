#!/bin/bash

export JAR_TARGET="fluentd-demo-0.0.1-SNAPSHOT.jar"
export STAGE="local"

DOCKER_NETWORK="docker-local-network"
DOCKER_IMAGE="fluentd-app"
IMAGE_TAG="latest"
CONTAINER_NAME="fluentd-app"

function network_check {
    NETWORK_NOT_EXIST=true
    declare -a items=($(docker network ls))
    for item in "${items[@]}" ; do
        if [ "$item" == "$DOCKER_NETWORK" ]; then
            NETWORK_NOT_EXIST=false
            break
        fi
    done
    if "$NETWORK_NOT_EXIST"; then
        echo "network create: $DOCKER_NETWORK"
        docker network create $DOCKER_NETWORK
    fi
}

#if ! [ "$(docker ps -q)" == "" ]; then
#    echo "========== docker stop =========="
#    docker stop $(docker ps -q)
#fi
#if ! [ "$(docker ps -q -a)" == "" ]; then
#    echo "========== docker rm =========="
#    docker rm $(docker ps -q -a)
#fi
if ! [ "$(docker images -q $DOCKER_IMAGE)" == "" ]; then
    if ! [ "$(docker ps -q -f name=$DOCKER_IMAGE)" == "" ]; then
        echo "========== docker stop =========="
        docker stop $DOCKER_IMAGE
        echo "========== docker rm =========="
        docker rm $DOCKER_IMAGE
    fi
    echo "========== delete old image =========="
    docker rmi $DOCKER_IMAGE:$IMAGE_TAG
fi
#echo "========== docker-compose config =========="
#docker-compose config
#echo "========== docker-compose up -d =========="
#docker-compose up -d
#echo "========== docker ps =========="
#docker ps

# network exist check
network_check


echo "========== Gradle build =========="
./gradlew -v
./gradlew build -x test

echo "========== docker build =========="
docker build --no-cache -t $DOCKER_IMAGE:$IMAGE_TAG .
echo "========== docker run =========="
docker run \
    -it \
    -d \
    -e STAGE=$STAGE \
    -e JAR_TARGET=$JAR_TARGET \
    --net $DOCKER_NETWORK \
    --name $CONTAINER_NAME \
    -p 8080:8080 $DOCKER_IMAGE:$IMAGE_TAG

docker exec -it $(docker ps -q -f name=fluentd-app) /bin/bash
