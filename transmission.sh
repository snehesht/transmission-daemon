#!/bin/bash

# Install docker
install() {
    echo $#
}

# build docker container
build() {
    docker build -t transmission .
}

# run the container
run() {
    if [[ $# != 2 ]]; then
        echo $#
        echo "Usage: $0 YOUR_PASSWORD_HERE TORRENTS_DIR_ABSOLUTE_PATH"
        echo " "
        echo "eg: $0 hD6Tnl5Dk6waNmXK /storage/torrents"
        echo " "
    else
        mkdir -p "$2/complete"
        mkdir -p "$2/incomplete"
        docker run -d --name transmission0 \
            -p 12345:12345 -p 12345:12345/udp \
            -p 9091:9091 \
            -e ADMIN_PASS=$1 \
            -v $2/complete:/torrents/complete \
            -v $2/incomplete:/torrents/incomplete \
            transmission
    fi
}

if [[ $# == 0 ]]; then
    echo "Usage:: \n"
    echo "commands: install, build and run"
elif [[ $1 == "build" ]]; then
    build
elif [[ $1 == "run" ]]; then
    run "${@:2}"
elif [[ $1 == "install" ]]; then
    # Install docker
    install
fi
