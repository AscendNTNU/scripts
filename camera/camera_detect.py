#!/usr/bin/env python

# 
# Script for creating persistent camera symlinks for a single ELP wide angle camera
# and a number of Logitech C920 cameras. 
#
# The script creates a udev rule file using name and serial attributes to create
# symlinks such as '/dev/videoFront' for a front mounted camera regardless of
# the port it in connected to and the order the cameras are connected to the computer.
# The number of rules and the names of the symlinks are determined by the content of
# the DIRECTIONS array.
#
# Written by: Martin Sollie (martin.sollie@ascendntnu.no)
# For:        Ascend NTNU (ascendntnu.no)
#

import glob, os, time, subprocess, sys
from select import select

def main():
	CAMERA_PATH = "/dev/video*"
	V4L_PATH = "/dev/v4l/by-id/*"
	filename = "/tmp/cameras.rules"
	final_dest = "/etc/udev/rules.d/cameras.rules"
	connected = []
	DIRECTIONS = ["front", "left", "right", "back", "fisheye"]

	print "WARNING: This program will overwrite any existing file",final_dest
	print "Please disconnect all cameras."
	run = raw_input('Do you want to continue?[Y/N]: ')
	if run == "Y":
		file = open(filename,'w')
		if len(glob.glob(CAMERA_PATH)) > 0: #Cameras detected before the user is asked to connect any
			connected = glob.glob(V4L_PATH)
			print "Some cameras are already connected. These will be ignored:"
			for camera in connected:
				print camera

		for direction in DIRECTIONS:
			print "\nPlease connect", direction, "camera, or press enter to skip"
			
			#Poll until a change in number of connected cameras is detected, or user skips
			time.sleep(0.1)
			skip = False
			while len(glob.glob(V4L_PATH)) == len(connected):
				rlist, _, _ = select([sys.stdin], [], [], 0.5)
				if rlist:
					s = sys.stdin.readline()
					print s
					if s == '\n':
						skip = True
						break
			if skip == True:
				continue
			device_list = glob.glob(V4L_PATH)
			if len(device_list) == ( len(connected) + 1 ):
				# Get type and serial number of the camera, create symlink in rules file
				for device in device_list:
					if device not in connected:
						print "New device on", device
						name = device.split("-")[2]
						if name.find("C920") > 0:
							serial = name.split("_")[5]
							string = 'ATTR{name} == "HD Pro Webcam C920", ATTRS{serial}=="'+serial+'", SYMLINK+="video'+direction.title()+'"\n'
						else:
							string = 'ATTR{name} == "USB 2.0 Camera", SYMLINK+="video'+direction.title()+'"\n'
						file.write(string);
						connected.append(device)
						print "Device added with symlink /dev/video"+direction.title()

			else:
				#The number of cameras either decreased or increased by more than one
				print("ERROR: Disconnected camera or multiple new cameras connected at once. Aborting.")
				os.remove(filename)
			 	return 1
		file.close()
		print "\nRules file\033[94m",filename,"\033[0mcreated. Moving to protected path\033[94m",final_dest,"\033[0m"
		
		#Move the rules file to the correct location. The user may be asked for administrator credentials.
		proc = subprocess.Popen(["sudo","mv",filename,final_dest])
		proc.wait()
		return 0
		
	else:
		print "Program aborted."
		return 0

main()
