#!/bin/bash

socket=/tmp/aggietimed.sock

while true
do
    aggietimed -d --socket-path $socket

    if [ $? -eq 0 ]
    then
        break
    else
        rm $socket
        sleep 1
    fi
done
