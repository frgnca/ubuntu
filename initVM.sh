#!/bin/bash
sudo /bin/bash -c 'ufw allow ssh && ufw --force enable && apt-get update && apt-get -y upgrade && apt-get -y install linux-virtual linux-tools-virtual linux-cloud-tools-virtual && sed -i "s#dhcp4: yes#dhcp4: no\n      addresses: [192.168.1.90/24]\n      gateway4: 192.168.1.254\n      nameservers:\n        addresses: [8.8.8.8,1.1.1.1]#" /etc/netplan/01-netcfg.yaml'
rm "$0"
reboot
