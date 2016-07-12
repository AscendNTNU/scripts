#!/bin/bash

FRONT_PORT=14000
LEFT_PORT=14001
BACK_PORT=14002
RIGHT_PORT=14003
FISHEYE_PORT=14004

# Preview all streams
gst-launch-1.0 udpsrc port=$FISHEYE_PORT ! application/x-rtp,encoding-name=JPEG,payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
gst-launch-1.0 udpsrc port=$FRONT_PORT ! application/x-rtp,encoding-name=JPEG,payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
gst-launch-1.0 udpsrc port=$LEFT_PORT ! application/x-rtp,encoding-name=JPEG,payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
gst-launch-1.0 udpsrc port=$BACK_PORT ! application/x-rtp,encoding-name=JPEG,payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
gst-launch-1.0 udpsrc port=$RIGHT_PORT ! application/x-rtp,encoding-name=JPEG,payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
wait
