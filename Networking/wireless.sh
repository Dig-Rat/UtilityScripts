#!/bin/bash

# This will scan for local wireless networks.
sudo iw dev wlan0 scan | grep S:

#nmcli dev wifi