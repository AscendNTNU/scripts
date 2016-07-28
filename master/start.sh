clear
echo "Did you remember to copy code changes to the Intel NUC drone workspace?"
echo "If not: Run upload_code_to_drone.sh (located in /home/ascend/dronemaster/scripts/master)"
echo "[Press enter...]"
read user1
echo "Did you remember to compile your nodes on the drone?"
echo "If not: Run catkin_make in /home/ascend/drone/drone_workspace after ssh'ing in"
echo "[Press enter]"
read user2
echo "Did you remember to compile your nodes on the dronemaster?"
echo "If not: Run catkin_make in /home/ascend/dronemaster/dronemaster_workspace"
echo "[Press enter]"
read user3
echo ""

# Start one terminal with two tabs
echo "I'm opening a terminal for you, with two tabs."
echo "In the first tab:"
echo "  $ cd /home/ascend/scripts/"
echo "  $ ./start_mav.sh"
echo "In the second tab:"
echo "  $ cd /home/ascend/scripts/"
echo "  $ ./start_stream.sh"
echo "Press enter when you are ready..."
read user4

gnome-terminal --tab-with-profile=Dronemaster --title="MAV" -e \
               "ssh ascend@ascend-nuc" \
               --tab-with-profile=Dronemaster --title="GStreamer" -e \
               "ssh ascend@ascend-nuc"
echo "Press enter to continue..."
read user5
clear

# Start another terminal with three tabs
echo " "
echo "I'm opening another terminal for you, with three tabs."
echo "In the first tab:"
echo "  $ rosrun mission_debugger mission_debugger"
echo "In the second tab:"
echo "  $ roslaunch lidar_obstacle_detection lidar_dronemaster.launch"
echo "In the third tab:"
echo "  $ roslaunch ground_bot_state_estimation ground_bot_state_estimation_node.launch"
echo "Press enter when you are ready"
read user6

export ROS_MASTER_URI=http://192.168.1.151:11311
gnome-terminal --tab-with-profile=Dronemaster --title="Mission debugger" \
               --tab-with-profile=Dronemaster --title="Lidar" \
               --tab-with-profile=Dronemaster --title="Groundbot"
