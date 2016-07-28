#!/bin/bash

# This script will kill the following nodes.

# obstacle detection nodes
killall Rb_w_node
killall Rw_b_node
killall CEPA_modified_node
killall lidar_filter_node
killall scan_padding_node
killall urg_node

# position controller node
killall main_pos

# localization nodes
killall line_counter_node
killall state_estimation_node

# mavros, gstreamer and ros
killall mavros_node
killall roscore
killall gst-launch-1.0
