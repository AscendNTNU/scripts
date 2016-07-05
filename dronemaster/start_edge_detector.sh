#!/bin/bash
# Starts 5 versions of the Edge Detector Node

x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_front'
sleep 2
x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_left'
sleep 2
x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_right'
sleep 2
x-terminal-emulator -e '/bin/bash /home/ascend/scripts/dronemaster/edge_detector_back'
sleep 2
$SHELL
