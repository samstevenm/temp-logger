# Logging Temperatures with a Raspi and ds18b20 sensors(s)
### Much credit to https://tutorials-raspberrypi.com/raspberry-pi-temperature-sensor-1wire-ds18b20/
### Data wire(s) should be connected to GPIO 4. Also need to connect GND and 3.3-5V.

`sudo modprobe w1-gpio`
`sudo modprobe w1-therm`

### Check that it worked
`lsmod`

### The modules should now be listed, if not, a GPIO pin other than 4 is used or an error occurred while activating.
### Might also check `sudo raspi-config` > interafacing options > 1 wire
### To load the modules every time, we'll add them to `/etc/modules`

`sudo echo >> w1_gpio /etc/modules`
`sudo echo >> w1_ther /etc/modules`

### For the next step, we first need the ID of the sensor(s).
### If connecting several in parallel, it is best to test each one individually and make a note of it's ID.
### Go to the w1 directory and list the files

`cd /sys/bus/w1/devices/`
`ls`

### Sensors might be called 10-000802b4ba0e, or 28-0516803024ff, or something similar
### We'll use this ID we use to query the sensor (please adjust ID)

### Use a command like this to get the output of the sensor
`cat /sys/bus/w1/devices/10-000802b4ba0e/w1_slave`
`cat /sys/bus/w1/devices/28-0516803024f/w1_slave`

### In the output we see the last indication of the temperature (in “milli degree”)
```
31 00 4b 46 ff ff 05 10 1c : crc=1c YES
31 00 4b 46 ff ff 05 10 1c t=24437
```
### Divided by 1000, we'd get 24.437 ° C.
