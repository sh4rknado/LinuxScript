#!/bin/bash

echo -e "\n Basic requirements \n"
apt install wget gnupg2 ca-certificates apt-transport-https dirmngr gnupg software-properties-common multiarch-support

echo -e "\n Enable installation of MongoDB 3.4 \n"
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc |  apt-key add -
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

echo -e "\nInstall old libssl required by MongoDB\n"
wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb
dpkg -i libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb

echo -e "\n Install JDK 8 \n"
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public |  apt-key add -
apt update && apt install adoptopenjdk-8-hotspot

echo -e "\n Set JDK for Unifi \n"
echo "JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64" > /etc/default/unifi

echo -e "\n Install Unifi Controller \n"
apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list
apt update && apt install unifi
