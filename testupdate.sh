#!/bin/bash
 
HOST=hsia.rotana.com
MTUSER=admin

echo Please type Mikrotik public IP:
read MTADDR

echo Please type Hotspot Profile name:
read HSPROF

echo Please type Hotspot Name:
read HSNAME

echo Please type Hotspot Address related to Hotspot Profile:
read HSADDR

sshpass -p 'Bhu89ol.' scp /Users/sysadm/Downloads/mikrotik/${HOST}/intermediaries.crt ${MTUSER}@${MTADDR}:/${HOST}/intermediaries.crt >/dev/null 
sshpass -p 'Bhu89ol.' scp /Users/sysadm/Downloads/mikrotik/${HOST}/${HOST}.crt ${MTUSER}@${MTADDR}:/${HOST}/${HOST}.pem >/dev/null
sshpass -p 'Bhu89ol.' scp /Users/sysadm/Downloads/mikrotik/${HOST}/${HOST}.key ${MTUSER}@${MTADDR}:/${HOST}/${HOST}.key >/dev/null
 
sshpass -p 'Bhu89ol.' ssh -T ${MTUSER}@${MTADDR} <<EOF >/dev/null
:delay 3
 
/certificate import file-name="intermediaries.crt" passphrase=""
/certificate import file-name="${HOST}.crt" passphrase=""
/certificate import file-name="${HOST}.key" passphrase=""
/file remove "intermediaries.crt"
/file remove "${HOST}.pem"
/file remove "${HOST}.key"
 
:delay 3
 
/ip hotspot profile remove ${HSPROF}
 
:delay 3
 
/ip hotspot profile add name=${HSPROF} hotspot-address=${HSADDR} dns-name=hsia.rotana.com html-directory=hotspot login-by=mac,https,http-pap mac-auth-mode=mac-as-username-and-password ssl-certificate=hsia.rotana.com.crt_0 use-radius=yes radius-mac-format=XX:XX:XX:XX:XX:XX radius-accounting=yes radius-interim-update=00:15:00 nas-port-type=19

:delay 3

/ip hotspot set hotspot1 profile=${HSPROF}
 
EOF
