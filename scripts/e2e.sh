#!/bin/bash

	export CWD_VOL=$(docker volume create)
  container=$(docker create -v $CWD_VOL:$PWD alpine /bin/sleep 30)
  cleanup() {
    echo "Cleaning up"
    docker volume rm $CWD_VOL
    docker rm --force $container
  }
  docker cp $PWD $container:/$(dirname $PWD)
  trap cleanup EXIT
	go test -v ./test -race -coverprofile=integ.txt -covermode=atomic
