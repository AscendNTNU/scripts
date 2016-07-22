#!/bin/bash

RECEIVE_FRONT_PORT=12000
RECEIVE_LEFT_PORT=12001
RECEIVE_BACK_PORT=12002
RECEIVE_RIGHT_PORT=12003
RECEIVE_FISHEYE_PORT=12004

EDGEDETEC_FRONT_PORT=13000
EDGEDETEC_LEFT_PORT=13001
EDGEDETEC_BACK_PORT=13002
EDGEDETEC_RIGHT_PORT=13003

PREVIEW_FRONT_PORT=14000
PREVIEW_LEFT_PORT=14001
PREVIEW_BACK_PORT=14002
PREVIEW_RIGHT_PORT=14003
PREVIEW_FISHEYE_PORT=14004

gst-launch-1.0 udpsrc port=$RECEIVE_FISHEYE_PORT ! application/x-rtp,encoding-name=JPEG,payload=26 ! tee name=videoTee \
videoTee. ! queue ! udpsink host=localhost port=$PREVIEW_FISHEYE_PORT &

gst-launch-1.0 udpsrc port=$RECEIVE_FRONT_PORT   ! application/x-rtp,encoding-name=JPEG,payload=26 ! tee name=videoTee \
videoTee. ! queue ! udpsink host=localhost port=$EDGEDETEC_FRONT_PORT \
videoTee. ! queue ! udpsink host=localhost port=$PREVIEW_FRONT_PORT &

gst-launch-1.0 udpsrc port=$RECEIVE_LEFT_PORT    ! application/x-rtp,encoding-name=JPEG,payload=26 ! tee name=videoTee \
videoTee. ! queue ! udpsink host=localhost port=$EDGEDETEC_LEFT_PORT \
videoTee. ! queue ! udpsink host=localhost port=$PREVIEW_LEFT_PORT &

gst-launch-1.0 udpsrc port=$RECEIVE_BACK_PORT    ! application/x-rtp,encoding-name=JPEG,payload=26 ! tee name=videoTee \
videoTee. ! queue ! udpsink host=localhost port=$EDGEDETEC_BACK_PORT \
videoTee. ! queue ! udpsink host=localhost port=$PREVIEW_BACK_PORT &

gst-launch-1.0 udpsrc port=$RECEIVE_RIGHT_PORT   ! application/x-rtp,encoding-name=JPEG,payload=26 ! tee name=videoTee \
videoTee. ! queue ! udpsink host=localhost port=$EDGEDETEC_RIGHT_PORT \
videoTee. ! queue ! udpsink host=localhost port=$PREVIEW_RIGHT_PORT &

wait
