#!/bin/bash

# Updating package index
sudo apt-get update

# Installing desktop environment
sudo apt-get install supervisor xvfb x11vnc xfce4 shimmer-themes gnome-icon-theme-full -y
git clone git://github.com/kanaka/noVNC ~/noVNC

# Setting DSIPLAY in .bashrc
echo "export DISPLAY=localhost:99" >> ~/.bashrc

# Create run file
echo 'echo VNC client running at https://$C9_HOSTNAME/vnc.html' > runc9vnc.sh
echo 'echo' >> runc9vnc.sh
echo 'cd' $(pwd) >> runc9vnc.sh
echo supervisord -c supervisord.conf >> runc9vnc.sh
chmod +x runc9vnc.sh

# Preparing for ROS install
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116

# Updating package index
sudo apt-get update

# Installing Full ROS Indigo Desktop
sudo apt-get install ros-indigo-desktop-full -y

# Initialize rosdep
sudo rosdep init
rosdep update

# Setting up ROS in .bashrc
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Installing rosinstall
sudo apt-get install python-rosinstall -y