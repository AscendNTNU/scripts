#!/bin/bash

# This script will start the following nodes.

cd /home/ascend/drone/drone_workspace/
source devel/setup.bash
roscore &

sleep 1
echo "Starting MAVROS"
sleep 2

roslaunch mavros px4.launch fcu_url:=/dev/ttyUSB0:921600 &

sleep 1
echo "Starting state estimation node"
sleep 2

rosrun state_estimation_node state_estimation_node &

sleep 1
echo "Starting line counter node"
sleep 2

rosrun line_counter_node line_counter_node &

sleep 1
echo "Starting urg node"
sleep 2

rosrun urg_node urg_node _ip_address:=192.168.2.10 &

sleep 1
echo "Starting position controller"
sleep 2

roslaunch position_controller controller.launch &

sleep 1
echo "Starting lidar obstacle detection"
sleep 2

roslaunch lidar_obstacle_detection lidar_drone.launch &

wait

