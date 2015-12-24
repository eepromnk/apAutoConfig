# apAutoConfig

This bash script configures a [Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/) as an anonymizing tor proxy. It can also be used as a simple wifi hotspot by commenting out or deleting everything below the "tor configuration" comment in `apAutoConfig.sh`.

The script downloads, installs, and configures three pieces of software: hostapd, isc-hdcp-server, and tor. This script has only been tested on a [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/) running a clean install of [Kali Linux](https://www.offensive-security.com/kali-linux-vmware-arm-image-download/) with a [Realtek 5370](http://www.amazon.com/gp/aw/d/B00GFAN498/ref=psd_mlt_nbc_B00ABD4AXO_ri) wifi dongle, but there's no reason it shouldn't work with [Raspbian](https://www.raspbian.org/) and any wireless chipset based on the nl80211 driver. Refer to the [wiki](http://elinux.org/RPi_USB_Wi-Fi_Adapters) for a complete list of supported chipsets.

There are no prompts for user input during configuration as this script was written for a specific use case. It should, however, work fine for most people without modification. (You may want to change the ssid and password values in /etc/hostapd/hostapd.conf before deploying.)

*This script is based on two tutorials that can be found [here](http://orxgilly.com/raspberry-pi-wireless-router/) and [here](https://learn.adafruit.com/onion-pi/overview).*

# Notes
In order to make `apAutoConfig.sh` executable you must place it into /bin on your Raspberry Pi, fire up a command prompt, and run `chmod +x apAutoConfig.sh`. After that simply type apAutoConfig.sh into your command prompt and hit enter.

After running `apAutoConfig.sh` you must restart your Raspberry Pi and enter:

	sudo service hostapd start
	sudo service isc-dhcp-server start
	sudo service tor start

If you'd like to avoid entering the above commands *every time* you turn on your Raspberry Pi, open a command prompt and enter:

	 sudo update-rc.d hostapd enable
	 sudo update-rc.d isc-hdcp-server enable
	 sudo update-rc.d tor enable
	 
*I have not tested the auto-run commands above. Let me know if they don't work and I'll make corrections*
