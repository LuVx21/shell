#! /bin/bash

version=5.6.4
# https://services.gradle.org/distributions/gradle-4.5.1-bin.zip
url=https://downloads.gradle-dn.com/distributions/gradle-$version-bin.zip
filename=gradle-$version-bin.zip
sudo wget -c $url -O $filename

sudo mkdir -p /opt/install
sudo unzip -d /opt/install $filename
sudo ln -s /opt/install/gradle-$version /opt/gradle

sudo rm -f $filename
