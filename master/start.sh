echo "This script will start all nodes on both the drone and the dronemaster."
read user0
echo "Did you remember to copy code changes to the Intel NUC drone workspace?"
echo "If not: Run "
read user1
echo "Did you remember to compile your nodes on the drone? [Press enter]"
read user2
echo "Did you remember to compile your nodes on the dronemaster? [Press enter]"
read user3
echo ""

# Start one terminal with two tabs
echo "Opening a terminal to setup drone..."
echo "Note! You need to manually enter the command written in the title of the tabs."
echo "Continue? [Press enter]"
read user4

gnome-terminal --tab --title="/home/scripts/start_mav.sh" -e \
               "ssh ascend@ascend-nuc" \
               --tab --title="/home/scripts/start_stream.sh" -e \
               "ssh ascend@ascend-nuc"

# Start another terminal with three tabs
echo " "
echo "Opening a terminal with dronemaster applications..."
echo "Note! You need to manually enter the command written in the title of the tabs."
echo "Continue? [Press enter]"
read user5

export ROS_MASTER_URI=http://192.168.1.151:11311
gnome-terminal --tab --title="rosrun mission_debugger mission_debugger" \
               --tab --title="roslaunch lidar_obstacle_detection lidar_dronemaster.launch" \
               --tab --title="roslaunch ground_bot_state_estimation ground_bot_state_estimation_node.launch"
