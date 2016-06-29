#!/bin/bash

FRONT_PORT=12000
LEFT_PORT=12001
BACK_PORT=12002
RIGHT_PORT=12003
FISHEYE_PORT=12004
RECEIVER_IP="192.168.1.${1:-151}"

cameras=(/dev/videoFront /dev/videoLeft /dev/videoRight /dev/videoBack /dev/videoFisheye)

echo "Receiver IP:$RECEIVER_IP"
for entry in "/dev/"video*; do
	if [ "$entry" = "/dev/videoFront" ]; then
		echo "Starting stream from $entry"
		gst-launch-1.0 v4l2src device=/dev/videoFront ! image/jpeg, width=1920, height=1080, framerate=30/1  ! rtpjpegpay ! udpsink host=$RECEIVER_IP port=$FRONT_PORT &
		delete=(/dev/videoFront)
		cameras=( "${cameras[@]/$delete}" )
		v4l2-ctl --device=$entry -c power_line_frequency=1
		v4l2-ctl --device=$entry -c focus_auto=0
		v4l2-ctl --device=$entry -c focus_absolute=0
	elif [ "$entry" = "/dev/videoLeft" ]; then
		echo "Starting stream from $entry"
		gst-launch-1.0 v4l2src device=/dev/videoLeft ! image/jpeg, width=1920, height=1080, framerate=30/1  ! rtpjpegpay ! udpsink host=$RECEIVER_IP port=$LEFT_PORT &
		delete=(/dev/videoLeft)
		cameras=( "${cameras[@]/$delete}" )
		v4l2-ctl --device=$entry -c power_line_frequency=1
		v4l2-ctl --device=$entry -c focus_auto=0
		v4l2-ctl --device=$entry -c focus_absolute=0
	elif [ "$entry" = "/dev/videoRight" ]; then
		echo "Starting stream from $entry"
		gst-launch-1.0 v4l2src device=/dev/videoRight ! image/jpeg, width=1920, height=1080, framerate=30/1  ! rtpjpegpay ! udpsink host=$RECEIVER_IP port=$RIGHT_PORT &
		delete=(/dev/videoRight)
		cameras=( "${cameras[@]/$delete}" )
		v4l2-ctl --device=$entry -c power_line_frequency=1
		v4l2-ctl --device=$entry -c focus_auto=0
		v4l2-ctl --device=$entry -c focus_absolute=0
	elif [ "$entry" = "/dev/videoBack" ]; then
		echo "Starting stream from $entry"
		gst-launch-1.0 v4l2src device=/dev/videoBack ! image/jpeg, width=1920, height=1080, framerate=30/1  ! rtpjpegpay ! udpsink host=$RECEIVER_IP port=$BACK_PORT &
		delete=(/dev/videoBack)
		cameras=( "${cameras[@]/$delete}" )
		v4l2-ctl --device=$entry -c power_line_frequency=1
		v4l2-ctl --device=$entry -c focus_auto=0
		v4l2-ctl --device=$entry -c focus_absolute=0
	elif [ "$entry" = "/dev/videoFisheye" ]; then
		echo "Starting stream from $entry"
		gst-launch-1.0 v4l2src device=/dev/videoFisheye ! image/jpeg, width=1280, height=720, framerate=60/1  ! rtpjpegpay ! udpsink host=$RECEIVER_IP port=$FISHEYE_PORT &
		delete=(/dev/videoFisheye)
		cameras=( "${cameras[@]/$delete}" )
	fi
done

#Warn about missing cameras
for i in ${cameras[@]}; do
	echo "$i not started"
done

wait

