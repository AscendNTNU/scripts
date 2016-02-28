#!/usr/bin/env python
import glob, os, time, subprocess

def main():
	CAMERA_PATH = "/dev/video*"
	V4L_PATH = "/dev/v4l/by-id/*"
	filename = "/tmp/cameras.rules"
	final_dest = "/etc/udev/rules.d/cameras.rules"
	connected = []
	DIRECTIONS = ["front", "left", "right"]#, "back", "fisheye"]

	print "WARNING: This program will overwrite any existing file",final_dest
	run = raw_input('Do you want to continue?[Y/N]: ')
	if run == "Y":
		file = open(filename,'w')
		if len(glob.glob(CAMERA_PATH)) > 0:
			connected = glob.glob(V4L_PATH)
			print "Some cameras are already connected. These will be ignored:"
			for camera in connected:
				print camera

		for direction in DIRECTIONS:
			print "\nPlease connect", direction, "camera"
			while len(glob.glob(V4L_PATH)) == len(connected):
				time.sleep(0.1)
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
				print("ERROR: Disconnected camera or multiple new cameras connected at once. Aborting.")
				os.remove(filename)
			 	return 1
		file.close()
		print "\nRules file\033[94m",filename,"\033[0mcreated. Moving to protected path\033[94m",final_dest,"\033[0m"
		proc = subprocess.Popen(["sudo","mv",filename,final_dest])
		proc.wait()
		return 0
		
	else:
		print "Program aborted."
		return 0

main()
