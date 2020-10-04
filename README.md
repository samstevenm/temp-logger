# Logging Temperatures with a Raspi and ds18b20 sensors(s)

##### Much credit to https://tutorials-raspberrypi.com/raspberry-pi-temperature-sensor-1wire-ds18b20/
Sensor data wire(s) should be connected to GPIO 4.  
Also need to connect GND and 3.3-5V.  

Initialize the sensors:  
`sudo modprobe w1-gpio`  
`sudo modprobe w1-therm`  

Check that it worked:  
`lsmod`

The modules should now be listed, if not, ensure GPIO pin 4 was used.  
If yes, perhaps some error occurred while activating.  
Might also check `sudo raspi-config` > interafacing options > 1 wire  

To load the modules every time, we'll add them to `/etc/modules`  
`sudo echo >> w1_gpio /etc/modules`  
`sudo echo >> w1_ther /etc/modules`  

##### Getting the ID(s) of the sensor(s).
If connecting several in parallel, it is best to connect one at a time.  
Test each sensor individually, and make a note of it's ID.  

Go to the w1 directory and list the files:  
`cd /sys/bus/w1/devices/`  
`ls`  

Sensors might look like  10-000802b4ba0e, 28-0516803024ff, or something similar.  
We'll need this ID we use to query the sensor (adjust ID to match _your_ sensor)  

##### Getting the output of sensor:
Use a command like this to get the output of a sensor  
`cat /sys/bus/w1/devices/10-000802b4ba0e/w1_slave`  
`cat /sys/bus/w1/devices/28-0516803024f/w1_slave`  

Sample output, the value after `t=` is your temp in (in “mili-degrees °C”)  
```
31 00 4b 46 ff ff 05 10 1c : crc=1c YES
31 00 4b 46 ff ff 05 10 1c t=24437
```
Divided by 1000, we'd get 24.437 °C.

##### For examples of transforming and showing these values:
See [`tempshow.sh`](tempshow.sh)  
Consider making [`tempshow.sh`](tempshow.sh) executable `chmod +x tempshow.sh`  
Also consider removing ".sh" and placing at `/usr/bin/tempshow`  

##### For examples of logging these values
See [`templog.sh`](templog.sh)  
Same considerations as above apply.  
systemd files
[`templog.service`](templog.service)  
[`templog.timer`](templog.timer)  
to be placed at `/etc/systemd/system/`  
Use `systemctl` to `enable` | `start` | `stop` | `disable` | `restart`
