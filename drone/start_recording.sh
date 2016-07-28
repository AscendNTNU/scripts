rm -r /home/ascend/simen/data
mkdir /home/ascend/simen/data

cd /home/ascend/simen/catkin_ws
source devel/setup.bash
#catkin_make
#cp build/logting/logting src/logting/logting
rosrun logting logting 1

echo "Hang on 3 sec... renaming data directory..."
sleep 3
echo "Done"
mv /home/ascend/simen/data /home/ascend/simen/${1}
