# This script will upload local ROS nodes and scripts to the drone
# Local workspace:            /home/dronemaster/dronemaster_workspace
# Drone workspace: ascend-nuc:/home/ascend/drone/drone_workspace
# .git files are ignored

echo "Synchronizing local ROS nodes to drone (/home/ascend/drone/drone_workspace)"

echo "position_controller"
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/position_controller ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
echo "state_estimation_node"
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/state_estimation_node ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
echo "line_counter_node"
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/line_counter_node ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
echo "lidar_obstacle_detection"
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/lidar_obstacle_detection ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
echo "collision_avoidance"
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/collision_avoidance ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
echo "pos_vel_ref_selector"
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/pos_vel_ref_selector ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/

echo "Done"

echo "Synchronizing local scripts to drone (/home/ascend/scripts/)"
rsync -a /home/ascend/dronemaster/scripts/drone/ ascend@ascend-nuc:/home/ascend/scripts/
echo "Done"
