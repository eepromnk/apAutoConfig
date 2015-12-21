#!/bin/bash

#apAutoConfig configures your Raspberry Pi as a wireless access point and tor router.

#This script downloads, installs, and configures hostapd, isc-dhcp-server, and tor for use as an
#anonomizing access point. 


echo "Welcome to the future of anonymity!"

sudo ifdown wlan0

echo "Updating system software..."
#sudo apt-get update 

echo "Installing hostapd and the dhcp server..."
#sudo apt-get install hostapd isc-dhcp-server sed


#Test internet connection
host1=google.com
host2=wikipedia.org
##Uncomment before shipping##((ping -w5 -c3 $host1 || ping -w5 -c3 $host2) > /dev/null 2>&1) && echo "Internet connectivity - OK" || (echo "Internet connectivity - Down, Internet connectivity is required for this script to complete. exiting..." && exit 1)

echo "Updating system software..."
#sudo apt-get update 

echo "Installing hostapd and the dhcp server..."
#sudo apt-get install hostapd isc-dhcp-server

sudo sed -i 's/option domain-name "example.org";/#option domain-name "example.org";/' /etc/dhcp/dhcpd.conf
sudo sed -i 's/option domain-name-servers ns1.example.org, ns2.example.org;/#option domain-name-servers ns1.example.org, ns2.example.org;/' /etc/dhcp/dhcpd.conf
sudo sed -i 's/#authoritative;/authoritative;/' /etc/dhcp/dhcpd.conf

sudo sed -i -e "\$asubnet 192.168.42.0 netmask 255.255.255.0 {" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$arange 192.168.42.10 192.168.42.50;" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$aoption broadcast-address 192.168.42.255;" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$aoption routers 192.168.42.1;" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$adefault-lease-time 600;" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$amax-lease-time 7200;" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$aoption domain-name "local";" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$aoption domain-name-servers 8.8.8.8, 8.8.4.4;" /etc/dhcp/dhcpd.conf
sudo sed -i -e "\$a}" /etc/dhcp/dhcpd.conf




