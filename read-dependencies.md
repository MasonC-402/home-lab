## Removal of Driver
    
In order to remove the driver from your system open a terminal in the directory with the source code and execute the following command:

$ sudo make dkms_remove

Make

For building & installing the driver with 'make' use

$ make && make install

Package / Build dependencies (Kali)

$ sudo apt-get update
$ sudo apt-get install bc mokutil build-essential libelf-dev linux-headers-`uname -r`

For Raspberry (RPI)

$ sudo apt-get install raspberrypi-kernel-headers

Then change the platform in Makefile to 32-bit ARM architecture (RPi 1/2/3/ & 0/Zero):

$ sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
$ sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile

Or, for ARM64 (RPI 3B+, 4B and Zero2) you will need to run:

$ sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
$ sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile

In addition, if you receive an error message about unrecognized command line option ‘-mgeneral-regs-only’ (i.e., Raspbian Buster), you will need to run the following commands for ARM architecture, then retry building and installing:

$ export ARCH=arm
$ sed -i 's/^MAKE="/MAKE="ARCH=arm\ /' dkms.conf

Or, for ARM64 run the following before re-building:

$ export ARCH=arm64
$ sed -i 's/^MAKE="/MAKE="ARCH=arm64\ /' dkms.conf

Building the driver may exceed RAM on some RPi's resulting in a gcc: fatal error: Killed signal terminated program cc1 error. Swap space can be increased in /etc/dphys-swapfile e.g. to 2000 megabytes, followed by /etc/init.d/dphys-swapfile restart. Building on swap is very slow, however.

For setting monitor mode

    Fix problematic interference in monitor mode.

$ airmon-ng check kill

You may also uncheck the box "Automatically connect to this network when it is avaiable" in nm-connection-editor. This only works if you have a saved wifi connection.

    Set interface down

$ sudo ip link set wlan0 down

    Set monitor mode

$ sudo iw dev wlan0 set type monitor

    Set interface up

$ sudo ip link set wlan0 up

For setting TX power

$ sudo iw wlan0 set txpower fixed 3000

LED control
statically by module parameter in /etc/modprobe.d/8812au.conf or wherever, for example:

options 88XXau rtw_led_ctrl=0

value can be 0 or 1
or dynamically by writing to /proc/net/rtl8812au/$(your interface name)/led_ctrl, for example:

$ echo "0" > /proc/net/rtl8812au/$(your interface name)/led_ctrl

value can be 0 or 1
check current value:

$ cat /proc/net/rtl8812au/$(your interface name)/led_ctrl

USB Mode Switch

0: doesn't switch, 1: switch from usb2.0 to usb 3.0 2: switch from usb3.0 to usb 2.0

$ rmmod 88XXau
$ modprobe 88XXau rtw_switch_usb_mode=int (0: no switch 1: switch from usb2 to usb3 2: switch from usb3 to usb2)

NetworkManager

Newer versions of NetworkManager switches to random MAC address. Some users would prefer to use a fixed address. Simply add these lines below

[device]
wifi.scan-rand-mac-address=no

at the end of file /etc/NetworkManager/NetworkManager.conf and restart NetworkManager with the command:

$ sudo service NetworkManager restart
