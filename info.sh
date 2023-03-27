#!/bin/bash

echo Please type in the public IP of Mikrotik:
read MTADDR
 
sshpass -p 'ATV-R0tana2020' ssh -T admin@${MTADDR} "/ip hotspot profile print"

echo -----

sshpass -p 'ATV-R0tana2020' ssh -T admin@${MTADDR} "/ip hotspot print"
