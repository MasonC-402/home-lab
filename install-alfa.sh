#!/bin/bash
# this script runs the commands to install ALFA wireless drivers for Ununtu 18.04 and 
# 20.04.  It also installs the latest version of aircrack-ng and the latest version of dpgk
#This driver can be installed using [DKMS]. 
#This is a system which will automatically recompile and install a kernel module when a new kernel gets installed
# or updated. To make use of DKMS, install the dkms package, which on Debian (based) systems is done like this:
sudo apt-get install dkms
# Step 1: Download the driver, Make sure you have git installed
sudo apt-get install git
# Step 2: Clone this repository
 git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
cd rtl*

##Installation of Driver
#In order to install the driver open a terminal in the directory with the source code and execute the following command:
sudo make dkms_install

# If you want to remove the driver from your system open a terminal in the directory with the source code and execute the following command:
# sudo make dkms_remove