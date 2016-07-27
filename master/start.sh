echo "Opening a terminal with drone stuff"
sleep 1

# Drone terminal 1:
# Tab 1: MAVROS, state_estimation_node, line_counter_node, urg_node, position_controller
# Tab 2: gstreamer fisheye
# Tab 3: 2D LIDAR scanner
gnome-terminal --tab --title="MAVROS, Filter, Line Counter, URG, Position controller" -e "ssh ascend@ascend-nuc" --tab --title="GStreamer" -e "ssh ascend@ascend-nuc" --tab --title="Obstacle detection" -e "ssh ascend@ascend-nuc"

echo "Opening a terminal with dronemaster stuff"
sleep 1

# Dronemaster terminal 1:
# Tab 1: mission_debugger
# Tab 2: LIDAR detections for visualization
# Tab 3: Groundbot detection
gnome-terminal --tab --title="Mission debugger" -e ./start_mission_debugger.sh --tab --title="2D LIDAR" -e ./start_lidar_dronemaster.sh --tab --title="Ground bot estimation" -e ./start_ground_bot.sh
