#!/bin/bash

#apAutoConfig configures your Raspberry Pi as a wireless access point and tor router.

#This script downloads, installs, and configures hostapd, isc-dhcp-server, and tor for use as an
#anonomizing access point. 


sudo ifdown wlan0

echo "Updating system software..."
sudo apt-get update 

echo "Installing hostapd and the dhcp server..."
sudo apt-get install hostapd isc-dhcp-server sed


#Test internet connection
host1=google.com
host2=wikipedia.org

#Uncomment before running. The nested case statment breaks Sublime Text's syntax highlighter.
#((ping -w5 -c3 $host1 || ping -w5 -c3 $host2) > /dev/null 2>&1) && echo "Internet connectivity - OK" || (echo "Internet connectivity - Down, Internet connectivity is required for this script to complete. exiting..." && exit 1)

echo "Updating system software..."
sudo apt-get update 

echo "Installing hostapd and the dhcp server..."
sudo apt-get install hostapd isc-dhcp-server

########################
##Configure dhcpd.conf##
########################
sudo sed -i 's/option domain-name "example.org";/#option domain-name "example.org";/' /etc/dhcp/dhcpd.conf
sudo sed -i 's/option domain-name-servers ns1.example.org, ns2.example.org;/#option domain-name-servers ns1.example.org, ns2.example.org;/' /etc/dhcp/dhcpd.conf
sudo sed -i 's/#authoritative;/authoritative;/' /etc/dhcp/dhcpd.conf

sudo sed -i "\$asubnet 192.168.42.0 netmask 255.255.255.0 {" /etc/dhcp/dhcpd.conf
sudo sed -i "\$arange 192.168.42.10 192.168.42.50;" /etc/dhcp/dhcpd.conf
sudo sed -i "\$aoption broadcast-address 192.168.42.255;" /etc/dhcp/dhcpd.conf
sudo sed -i "\$aoption routers 192.168.42.1;" /etc/dhcp/dhcpd.conf
sudo sed -i "\$adefault-lease-time 600;" /etc/dhcp/dhcpd.conf
sudo sed -i "\$amax-lease-time 7200;" /etc/dhcp/dhcpd.conf
sudo sed -i "\$aoption domain-name "local";" /etc/dhcp/dhcpd.conf
sudo sed -i "\$aoption domain-name-servers 8.8.8.8, 8.8.4.4;" /etc/dhcp/dhcpd.conf
sudo sed -i "\$a}" /etc/dhcp/dhcpd.conf

########################
##Configure Interfaces##
########################
sudo sed -i 's/INTERFACES=""/INTERFACES="wlan0"/' /etc/default/isc-dhcp-server

sudo sed -i -e "\$aallow-hotplug wlan0" /etc/network/interfaces
sudo sed -i -e "\$aiface wlan0 inet static" /etc/network/interfaces
sudo sed -i -e "\$aaddress 192.168.42.1" /etc/network/interfaces
sudo sed -i -e "\$anetmask 255.255.255.0" /etc/network/interfaces
sudo sed -i -e "\$aup iptables-restore < /etc/iptables.ipv4.nat" /etc/network/interfaces

sudo ifconfig wlan0 192.168.42.1

echo > /etc/hostapd/hostapd.conf
sudo sed -i -e "1i interface=wlan0" /etc/hostapd/hostapd.conf
sudo sed -i -e "2i driver=nl80211" /etc/hostapd/hostapd.conf
sudo sed -i -e "3i ssid=onionpi" /etc/hostapd/hostapd.conf
sudo sed -i -e "4i hw_mode=g" /etc/hostapd/hostapd.conf
sudo sed -i -e "5i channel=6" /etc/hostapd/hostapd.conf
sudo sed -i -e "6i macaddr_acl=0" /etc/hostapd/hostapd.conf
sudo sed -i -e "7i auth_algs=1" /etc/hostapd/hostapd.conf
sudo sed -i -e "8i ignore_broadcast_ssid=0" /etc/hostapd/hostapd.conf
sudo sed -i -e "9i wpa=2" /etc/hostapd/hostapd.conf
sudo sed -i -e "10i wpa_passphrase=Raspberry" /etc/hostapd/hostapd.conf
sudo sed -i -e "11i wpa_key_mgmt=WPA-PSK" /etc/hostapd/hostapd.conf
sudo sed -i -e "12i wpa_pairwise=TKIP" /etc/hostapd/hostapd.conf
sudo sed -i -e "13i rsn_pairwise=CCMP" /etc/hostapd/hostapd.conf

 