#!/bin/bash

echo "######################"
echo "#    Ascend NTNU     #"
echo "#  Jetson TX2 Setup  #"
echo "######################"

echo "Enter the ID number of the jetson (1-4), followed by [ENTER]:"

read JETSON_ID

if [ $JETSON_ID -lt 1 ] || [ $JETSON_ID -gt 4 ]; then
	echo "ERROR: Invalid Jetson id: ${JETSON_ID}, must be in the range (1-4)"
	exit 1
fi

echo "The ID of the Jetson TX2 is ${JETSON_ID}"

if [ $JETSON_ID = '1' ]; then
	echo "This jetson will be set up as master."
fi

sleep 1

if [ 1 -eq 0 ]; then

echo "########################"
echo " STEP 1: Setup "
echo "########################"

sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
sudo apt-get update
sudo apt-get upgrade -y

echo "########################"
echo " STEP 2: Installing ROS "
echo "########################"

#sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116

sudo apt-get update
sudo apt-get install ros-kinetic-ros-base -y

sudo apt-get install python-rosdep -y

# This line fixes this bug http://answers.ros.org/question/54150/rosdep-initialization-error/
sudo c_rehash /etc/ssl/certs

sudo rosdep init
rosdep update

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source /opt/ros/kinetic/setup.bash

sudo apt-get install python-rosinstall -y

echo "############################"
echo " STEP 3: Creating workspace "
echo "############################"

WORKSPACE_PATH=~/catkin_ws

mkdir -p "$WORKSPACE_PATH"/src
cd "$WORKSPACE_PATH"/src
catkin_init_workspace
cd "$WORKSPACE_PATH"
catkin_make

echo "source $WORKSPACE_PATH/devel/setup.bash" >> ~/.bashrc

echo "########################"
echo "   SETP 4: Networking   "
echo "########################"

WIFI_SSID="BG78IA91"
WIFI_PSK="76G98s1NNh12ddsca"

sudo apt-get install bridge-utils -y


echo "###########################"
echo " STEP 5: Install utilities "
echo "###########################"

sudo apt install -y htop nano bmon ncdu
