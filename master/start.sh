clear

# Start one terminal with two tabs
echo "Opening a terminal to setup drone..."
echo "  Tab 1: mavros_node"
echo "         line_counter_nod"
echo "         state_estimation_node"
echo "         position_controller"
echo "         urg_node"
echo "         lidar_obstacle_detection"
echo "  Tab 2: gstreamer"
sleep 3

gnome-terminal --tab --title="MAV" -e                                                            \
               "ssh ascend@ascend-nuc 'bash -s' < /home/ascend/dronemaster/scripts/start_mav.sh" \
               --tab --title="GStreamer" -e                                                      \
               "ssh ascend@ascend-nuc 'bash -s' < /home/ascend/dronemaster/scripts/start_stream.sh"

# Start another terminal with three tabs
echo " "
echo "Opening a terminal with dronemaster stuff..."
echo "  Tab 1: mission_debugger"
echo "  Tab 2: start_lidar_dronemaster"
echo "  Tab 3: start_ground_bot"
sleep 3

export ROS_MASTER_URI=http://192.168.1.151:11311
gnome-terminal --tab --title="Mission debugger" -e \
               "/bin/bash rosrun mission_debugger mission_debugger" \
               --tab --title="Obstacle detection" -e \
               "/bin/bash roslaunch lidar_obstacle_detection lidar_dronemaster.launch" \
               --tab --title="Target detection" -e \
               "/bin/bash roslaunch ground_bot_state_estimation ground_bot_state_estimation_node.launch"
