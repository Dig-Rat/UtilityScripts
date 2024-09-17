#!/bin/bash

# Function to check internet connection
check_internet() {
    curl -s --head http://www.google.com | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
}

# Function to scan for Wi-Fi networks
scan_networks() {
    echo "Scanning for available Wi-Fi networks..."
    nmcli device wifi list
}

# Function to connect to a Wi-Fi network
connect_network() {
    read -p "Enter the SSID of the network you want to connect to: " ssid
    read -sp "Enter the password for $ssid: " password
    echo
    nmcli device wifi connect "$ssid" password "$password"
}

# Function to scan for Wi-Fi adapters
scan_adapters() {
    echo "Scanning for wireless adapters..."
    nmcli device
}

# Function to prompt user to set up a Wi-Fi adapter
setup_adapter() {
    read -p "Enter the name of the adapter you want to set up: " adapter
    # Here, you could add more specific setup steps for the adapter if needed
    echo "Setting up adapter $adapter..."
}

# Main script logic
if check_internet; then
    echo "You are connected to the internet."
else
    echo "No internet connection detected."

    scan_networks
    if [ "$(nmcli -t -f SSID dev wifi list | wc -l)" -gt 0 ]; then
        connect_network
    else
        scan_adapters
        if [ "$(nmcli device | grep wifi | wc -l)" -gt 0 ]; then
            setup_adapter
        else
            echo "No wireless adapters detected."
        fi
    fi
fi
