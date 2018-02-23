### USB utilities ###

This is a Darwin/OS X port of the USB utilities for Linux (usbutils v007). Similar to [https://github.com/barisbalic/lsusb-osx](https://github.com/barisbalic/lsusb-osx) except that instead of removing code I've just added conditionals to make it build on OS X while still allowing it to be built on Linux.

#### Building and Installing ####

Make sure you have the required dependencies:

	brew install pkg-config autoconf automake gcc@7 libusb libusb-compat

Then simply:

	git clone --recurse-submodules https://github.com/sigma-1/usbutils.git
	cd usbutils
	./autogen.sh
	make && sudo make install

#### Caveats ####

The 'lsusb -t' option does not work on OS X as it does under Linux. To amend for that I've added a simple function that instead just prints the output of 'ioreg -p IOUSB' since it's pretty much the same thing. As such:

	valex@darwin:~/usbutils(007)$ lsusb -t
	+-o Root  <class IORegistryEntry, id 0x100000100, retain 13>
	  +-o Root Hub Simulation Simulation@24000000  <class AppleUSBRootHubDevice, id 0x100000265, registered, matched, active, busy 0 (5 ms), retain 10>
	  | +-o Built-in iSight@24600000  <class AppleUSBDevice, id 0x100000266, registered, matched, active, busy 0 (980 ms), retain 22>
	  +-o Root Hub Simulation Simulation@26000000  <class AppleUSBRootHubDevice, id 0x10000026e, registered, matched, active, busy 0 (4 ms), retain 7>
	  | +-o Card Reader@26100000  <class AppleUSBDevice, id 0x10000026f, registered, matched, active, busy 0 (733 ms), retain 14>
	  +-o Root Hub Simulation Simulation@06000000  <class AppleUSBRootHubDevice, id 0x100000293, registered, matched, active, busy 0 (4 ms), retain 9>
	    +-o IR Receiver@06500000  <class AppleUSBDevice, id 0x100000294, registered, matched, active, busy 0 (690 ms), retain 17>
	    +-o Apple Internal Keyboard / Trackpad@06300000  <class AppleUSBDevice, id 0x1000002bc, registered, matched, active, busy 0 (1484 ms), retain 25>
	    +-o BRCM2046 Hub@06600000  <class AppleUSBDevice, id 0x1000002d3, registered, matched, active, busy 0 (474 ms), retain 15>
	      +-o Bluetooth USB Host Controller@06610000  <class AppleUSBDevice, id 0x1000002e3, registered, matched, active, busy 0 (372 ms), retain 20>

The 'lsusb -D' option does not work.

The 'usbhid-dump' command works but not right out of the box. This could potentially be fixed but until then there are some workarounds such as using a codeless kext to prevent Apple's drivers from hijacking the HID devices. There are discussions on the subject and similar subjects over at the libusb mailing list and stackoverflow.

The 'usb-devices' script does not work since it relies on sysfs, which isn't present in OS X. I might be able to write an OS X equivilent for that script when I find the time for it.
