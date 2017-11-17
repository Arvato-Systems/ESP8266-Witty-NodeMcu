# ESP8266, Witty, NodeMcu
This project shows a basic file structure with basic functions for a NodeMCU device. I use the buildin LED and LDR sensor of a Witty, but you can use all files without as a template.
## The Witty ##
The Witty contains of two boards, that can be seperated. You'll need the lower board during the development phase, as it offers an USB connection for programming the device.

[First Impression on ESP8266 Witty Cloud Board](https://yoursunny.com/t/2016/WittyCloud-first/)

The file layout will work for other ESP8266 boards as well.
## NodeMCU ##
[www.nodemcu.com](http://www.nodemcu.com/index_en.html) is a nice way of programming your ESP8266. Documentation can be found here [https://nodemcu.readthedocs.io](https://nodemcu.readthedocs.io).
### Firmware ###
The firmware can be customized by using a cloud service, that builds you the firmware with the modules you need. o to [NodeMCU custom builds](https://nodemcu-build.com/), build your firmware and flash it with [NodeMCU Flasher](https://github.com/nodemcu/nodemcu-flasher).
### Upload to the device ###
A nice tool to handle files on a NodeMCU is [ESPlorer](http://www.esp8266.com/viewtopic.php?f=22&t=882). The Java tool lets you modify local files, and upload the to devices via USB. Viewing files on devices and executing them is also a feature.

## Files ##
Do you remember the autoexec.bat? **init.lua** is executed right after the devices booted.
This sample project contains of 5 files.
1. init.lua
2. *test.lua*
3. config.lua
4. setup.lua
5. application.lua
### 1./2. init.lua / test.lua ###
As mentioned earlier, the init.lua is executed right after a devices boots. Since you can't stop this loading, *it is highly recommended to not create an init.lua during development*.

test.lua is started (e.g. after booting) to continue like in a productive life. The file content of the two files is the same.
### 3. config.lua ###
Configuration values like pins, or the SSID of the Wifi.
### 4. application.lua ###
This file contains the logic, that is executed