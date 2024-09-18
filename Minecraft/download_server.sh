#!/bin/bash

# Function to download the Minecraft server JAR file
download_minecraft_server()
{
    # URL for the Minecraft server JAR file
    SERVER_URL="https://piston-data.mojang.com/v1/objects/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar"
    SERVER_FILE="server.jar"
    
    echo "Downloading Minecraft server JAR file..."
    # Download the server JAR file using wget
    wget -O "$SERVER_FILE" "$SERVER_URL"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        echo "Download complete: $SERVER_FILE"
    else
        echo "Download failed."
        exit 1
    fi
}

# Main
download_minecraft_server