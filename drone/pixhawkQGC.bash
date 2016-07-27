#!/usr/bin/env bash
socat /dev/ttyUSB0,lockfile=pixhawk.lock,b921600 udp-recvfrom:54321,fork,sourceport=54322
#socat /dev/ttyUSB0,lockfile=pixhawk.lock,b921600 udp-recvfrom:54321,fork,UDP-SENDTO:192.168.1.73:54322

