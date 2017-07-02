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

# Updated for use with Leopard Imaging cameras (on Intel NUC) that all report the same serial number
# This script assumes that the cameras stay connected to the same USB port

import glob, os, time, subprocess, sys
from select import select

def main():
	CAMERA_PATH = "/dev/video*"
	USB_PATH_1 = "/dev/bus/usb/001/*" # The * does not necessarily correspond with the port number, we need to call udevadm info to know for sure
	USB_PATH_2 = "/dev/bus/usb/002/*"
	filename = "/tmp/cameras.rules"
	final_dest = "/etc/udev/rules.d/cameras.rules"
	connected = []
	DIRECTIONS = ["front", "left", "right", "fisheye"]

	print "WARNING: This program will overwrite any existing file",final_dest
	print "Please disconnect all cameras."
	run = raw_input('Do you want to continue?[Y/N]: ')
	if run == "Y":
		file = open(filename,'w')
		if len(glob.glob(USB_PATH_1))+len(glob.glob(USB_PATH_2)) > 0: #Cameras detected before the user is asked to connect any
			connected = glob.glob(USB_PATH_1)
			connected.extend(glob.glob(USB_PATH_2))
			print "Some devices are already connected. These will be ignored:"
			for device in connected:
				print device

		for direction in DIRECTIONS:
			print "\nPlease connect", direction, "camera, or press enter to skip"
			
			#Poll until a change in number of connected cameras is detected, or user skips
			time.sleep(0.1)
			skip = False
			while len(glob.glob(USB_PATH_1))+len(glob.glob(USB_PATH_2)) == len(connected):
				rlist, _, _ = select([sys.stdin], [], [], 0.5)
				if rlist:
					s = sys.stdin.readline()
					print s
					if s == '\n':
						skip = True
						break
			if skip == True:
				continue
			device_list = glob.glob(USB_PATH_1)
			device_list.extend(glob.glob(USB_PATH_2))
			if len(device_list) == ( len(connected) + 1 ):
				# Get the bus and port number of the USB port where the camera is connected
				for device in device_list:
					if device not in connected:
						print "New device on", device
						p = subprocess.Popen("udevadm info --attribute-walk "+device+" | grep KERNEL | head -1", stdout=subprocess.PIPE, shell=True)
						output, err = p.communicate()

						string = 'UBSYSTEM=="video4linux", SUBSYSTEMS=="usb", '+output+', SYMLINK+="video'+direction.title()+'"\n'
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
		# Reload the udev rules. After this the cameras must be reconnected for the symlinks to appear
		p = subprocess.Popen("sudo udevadm control --reload-rules && udevadm trigger", stdout=subprocess.PIPE, shell=True)
		return 0
		
	else:
		print "Program aborted."
		return 0

main()
