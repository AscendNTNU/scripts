#!/bin/bash
# Starts 5 versions of the Edge Detector Node

x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_front'
sleep 5
x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_left'
sleep 5
x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_right'
sleep 5
x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_back'
sleep 5
$SHELL
