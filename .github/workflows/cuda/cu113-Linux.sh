#!/bin/bash

# Strip the periods from the version number
OS_VERSION=$(echo $(lsb_release -sr) | tr -d .)
OS=ubuntu${OS_VERSION}

wget -nv https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-${OS}.pin
sudo mv cuda-${OS}.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget -nv https://developer.download.nvidia.com/compute/cuda/11.3.0/local_installers/cuda-repo-${OS}-11-3-local_11.3.0-465.19.01-1_amd64.deb
sudo dpkg -i cuda-repo-${OS}-11-3-local_11.3.0-465.19.01-1_amd64.deb

# TODO: If on version < 22.04, install via signal-desktop-keyring
# For future versions it's deprecated and should be moved into the trusted folder
# sudo mv /var/cuda-repo-${OS}-11-3-local/7fa2af80.pub /etc/apt/trusted.gpg.d/
sudo apt-key add /var/cuda-repo-${OS}-11-3-local/7fa2af80.pub

sudo apt-get -qq update
sudo apt install cuda cuda-nvcc-11-3 cuda-libraries-dev-11-3
sudo apt clean

rm -f https://developer.download.nvidia.com/compute/cuda/11.3.0/local_installers/cuda-repo-${OS}-11-3-local_11.3.0-465.19.01-1_amd64.deb