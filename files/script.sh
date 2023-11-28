#!/bin/bash

GLPIETC="/etc/glpi"
VARLIB="/var/lib/glpi"
VARLOG="/var/log/glpi"

echo `date` > /tmp/log.txt
if [ -d "$GLPIETC" ]; then
    echo "The directory $GLPIETC exists." >> /tmp/log.txt
else
    echo "The directory $GLPIETC does not exist." >> /tmp/log.txt
    mkdir -pv $GLPIETC >> /tmp/log.txt
fi

if [ -d "$VARLIB" ]; then
    echo "The directory $VARLIB exists." >> /tmp/log.txt
else
    echo "The directory $VARLIB does not exist." >> /tmp/log.txt
    mkdir -pv $VARLIB >> /tmp/log.txt
    cp -rv /var/www/html/files/* /var/lib/glpi >> /tmp/log.txt
fi


if [ -d "$VARLOG" ]; then
    echo "The directory $VARLOG exists." >> /tmp/log.txt
else
    echo "The directory $VARLOG does not exist." >> /tmp/log.txt
    mkdir -pv $VARLOG >> /tmp/log.txt
fi