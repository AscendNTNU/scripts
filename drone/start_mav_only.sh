cd /home/ascend/drone/drone_workspace/
source devel/setup.bash
roscore &

sleep 1
clear
echo "Starting MAVROS"
sleep 2

roslaunch mavros px4.launch fcu_url:=/dev/ttyUSB0:921600 &
