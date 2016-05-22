# Hello Debian

This project demonstrates building a deb file from a stack project.


## Installation

# Get the Logic Refinery key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 91E2A2AF


# Add the Logic Refinery repository.
echo 'deb http://logic-refinery.com/repos jessie main' | sudo tee /etc/apt/sources.list.d/logic-refinery.list


# Update apt and install the package
sudo apt-get update && sudo apt-get install hello-debian -y
