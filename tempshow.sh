#!/usr/bin/env bash

LOG_DIR=/home/pi/templog
LOG_FILE=$LOG_DIR/`date +%Y_%V`templog.csv

#Make the log dir if it doesn't exist
mkdir -p $LOG_DIR

#Check if the log file exists, if not make it and write the CSV headers
if [ ! -e "$LOG_FILE" ] ; then
            touch "$LOG_FILE"
            echo "timestamp,black,red,green,blue,white" > $LOG_FILE
fi

#Read Temperature
tempread=`cat /sys/bus/w1/devices/28-0516803024ff/w1_slave`
tempread_R=`cat /sys/bus/w1/devices/28-0316806082ff/w1_slave`
tempread_G=`cat /sys/bus/w1/devices/28-0316806035ff/w1_slave`
tempread_B=`cat /sys/bus/w1/devices/28-0516802e56ff/w1_slave`
tempread_W=`cat /sys/bus/w1/devices/28-0316805ff0ff/w1_slave`

#Get just temperature portion
temp=${tempread##*=}
temp_R=${tempread_R##*=}
temp_G=${tempread_G##*=}
temp_B=${tempread_B##*=}
temp_W=${tempread_W##*=}

#Divide by 1000 for Celsius with decimal
tempC=$( echo "scale=4; ($temp/1000)" | bc )
tempC_R=$( echo "scale=4; ($temp_R/1000)" | bc )
tempC_G=$( echo "scale=4; ($temp_G/1000)" | bc )
tempC_B=$( echo "scale=4; ($temp_B/1000)" | bc )
tempC_W=$( echo "scale=4; ($temp_W/1000)" | bc )

#Convert to Fahrenheit (/5*9 + 32) then divide by 1000 for decimcal
tempF=$( echo "scale=4; ((9/5) * $temp/1000) + 32" | bc )
tempF_R=$( echo "scale=4; ((9/5) * $temp_R/1000) + 32" | bc )
tempF_G=$( echo "scale=4; ((9/5) * $temp_G/1000) + 32" | bc )
tempF_B=$( echo "scale=4; ((9/5) * $temp_B/1000) + 32" | bc )
tempF_W=$( echo "scale=4; ((9/5) * $temp_W/1000) + 32" | bc )

#Print the values
echo "Black:" $tempF "°F"
echo "Red:" $tempF_R "°F"
echo "Green:" $tempF_G "°F"
echo "Blue:" $tempF_B "°F"
echo "White:" $tempF_W "°F"
