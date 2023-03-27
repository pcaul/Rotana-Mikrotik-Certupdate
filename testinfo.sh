#!/bin/bash

echo Please type in the public IP of Mikrotik:
read MTADDR

sshpass -p 'Bhu89ol.' ssh -T admin@${MTADDR} "/ip hotspot profile print"

echo -----

sshpass -p 'Bhu89ol.' ssh -T admin@${MTADDR} "/ip hotspot print"
