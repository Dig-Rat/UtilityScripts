#!/bin/bash
#############################
# download & install java openjdk

# install the system's default latest openjdk.
install_default()
{
sudo apt update
sudo apt install default-openjdk
}

# download openjdk 21
install_openjdk21()
{
# Download the OpenJDK 21 binaries
echo "Downloading OpenJDK 21..."
wget https://download.java.net/java/GA/jdk21/fd2272bbf8e04c3dbaee13770090416c/35/GPL/openjdk-21_linux-x64_bin.tar.gz

# Extract the tarball
echo "Extracting OpenJDK 21..."
tar -xzf openjdk-21_linux-x64_bin.tar.gz

# Move the extracted folder to /opt
echo "Moving JDK to /opt/..."
sudo mv jdk-21 /opt/

# Set environment variables to use OpenJDK 21: Add the following lines to your .bashrc or .profile:
# export JAVA_HOME=/opt/jdk-21
# export PATH=$JAVA_HOME/bin:$PATH
echo "Setting up environment variables..."
echo 'export JAVA_HOME=/opt/jdk-21' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Apply the changes by sourcing .bashrc
echo "Applying changes..."
source ~/.bashrc

echo "OpenJDK 21 installation is complete!"
}

# Change default JDK if needed.
change_default()
{
sudo update-java-alternatives --set openjdk-21
}

# check java version.
java_version()
{
java -version
}