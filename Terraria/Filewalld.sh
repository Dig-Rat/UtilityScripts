#!/bin/bash

# https://www.linode.com/docs/guides/host-a-terraria-server-on-your-linode/
# https://www.linode.com/docs/guides/introduction-to-firewalld-on-centos/

# Enable and start firewalld.
sudo systemctl enable firewalld && sudo systemctl start firewalld

# Use public zone by default. Verify with:
sudo firewall-cmd --get-active-zones

# Create a firewalld service file for Terraria:
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Terraria</short>
  <description>Open TCP port 7777 for incoming Terraria client connections.</description>
  <port protocol="tcp" port="7777"/>
</service>

# Enable the firewalld service, reload firewalld and verify that the Terraria service is being used:
sudo firewall-cmd --zone=public --permanent --add-service=terraria
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --permanent --list-services

# The output of the last command should be similar to:
# dhcpv6-client ssh terraria
