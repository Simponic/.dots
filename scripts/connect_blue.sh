#!/bin/sh

bluetoothctl connect $(bluetoothctl devices | grep $1 | awk '{ print $2 }')
