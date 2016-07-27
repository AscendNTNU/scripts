# This script will upload local ROS nodes and scripts to the drone
# Local workspace:            /home/dronemaster/dronemaster_workspace
# Drone workspace: ascend-nuc:/home/ascend/drone/drone_workspace
# .git files are ignored

echo "Synchronizing local ROS nodes to drone..."

rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/position_controller ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/state_estimation_node ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/line_counter_node ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/lidar_obstacle_detection ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/
rsync -a /home/ascend/dronemaster/dronemaster_workspace/src/collision_avoidance ascend@ascend-nuc:/home/ascend/drone/drone_workspace/src/

echo "Done"

echo "Local scripts have not been copied."
# Todo: Finish this
# echo "Synchronizing local scripts to drone..."
# rsync -a /home/ascend/dronemaster/
# echo "Done"