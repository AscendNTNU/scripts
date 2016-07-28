v4l2-ctl --device=/dev/videoFront -c power_line_frequency=1
v4l2-ctl --device=/dev/videoFront -c focus_auto=0
v4l2-ctl --device=/dev/videoFront -c focus_absolute=0

v4l2-ctl --device=/dev/videoBack -c power_line_frequency=1
v4l2-ctl --device=/dev/videoBack -c focus_auto=0
v4l2-ctl --device=/dev/videoBack -c focus_absolute=0

v4l2-ctl --device=/dev/videoLeft -c power_line_frequency=1
v4l2-ctl --device=/dev/videoLeft -c focus_auto=0
v4l2-ctl --device=/dev/videoLeft -c focus_absolute=0

v4l2-ctl --device=/dev/videoRight -c power_line_frequency=1
v4l2-ctl --device=/dev/videoRight -c focus_auto=0
v4l2-ctl --device=/dev/videoRight -c focus_absolute=0


