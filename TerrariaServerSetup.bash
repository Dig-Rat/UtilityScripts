#!/bin/bash
#######################################
# Purpose:
# setup for a terraria server.
# -install dependancies
# -configure firewall
# -add new user to host server
# -download and unzip server files.
# -give server perms
# -run server

# Don't forget to give this script exe perms.
#chmod +x script.sh
#######################################
# Assign variables to use within script.
port="7777"
user="terraria"
dump="terrariaDump.txt"
# Go home
cd ~
# Create file to dump all the script output to for debugging.
touch $dump
# Update and get dependancies
sudo apt update
sudo apt install -y wget
#sudo apt install -y tmux
sudo apt install -y unzip
# Show ip address for port-forwarding info.
echo ip addr show
# Enable and start firewall
sudo systemctl enable firewalld && sudo systemctl start firewalld
sudo firewall-cmd --get-active-zones
# Create firewall rule for server listening port.
sudo firewall-cmd --add-port=$port/tcp

# Tranlate the user input is all lowercase.
user = tr '[:upper:]' '[:lower:]' 
# Create new user to host server on.
sudo adduser $user
# https://askubuntu.com/questions/319714/proper-way-to-add-a-user-account-via-bash-script ######### better?
#sudo adduser myuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
#echo "myuser:password" | sudo chpasswd

# login to new user

# Go home
cd ~
# Download server files
wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip
# Unzip the downloaded files.
sudo unzip terraria-server-1449.zip
# Go to server directory
cd 1449/Linux/
# Give exe perms to server launch file
chmod +x TerrariaServer.bin.x86*

# Create a service for the terraria server and enable it to run on boot.
######### TO DO
# https://www.linode.com/docs/guides/host-a-terraria-server-on-your-linode/


# Create a file for server logging.
#####

# Start the server
./TerrariaServer.bin.x86_64


# Location for world files.
# ~/.local/share/Terraria/Worlds/
