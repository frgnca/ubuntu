#!/bin/bash
# Copyright (c) 2017-2020 Francois Gendron <fg@frgn.ca>
# MIT License

# transformVM.sh
# Transform Ubuntu Server 18.04.4 LTS template VM


################################################################################
# Set new configuration
newHostname="newhostname"
newUsername="newusername"
newIP="192.168.1.91"
########################
# Set internal variables
templateUser="username"
templateHostname="ubuntu"
templateIP="192.168.1.90"

# Create new user
adduser --gecos "" --force-badname $newUsername
usermod -aG sudo $newUsername

# Bring up to date
apt-get update > /dev/null 2>&1 && apt-get -y upgrade > /dev/null 2>&1

# Remove template user at next boot
echo '#!/bin/bash' > /etc/rc.local
echo 'userdel -r \'$templateUser >> /etc/rc.local
echo 'rm /etc/rc.local' >> /etc/rc.local
chmod +x /etc/rc.local

# Copy .bash_profile
cp /home/$templateUser/.bash_profile /home/$newUsername/.bash_profile

# Change static IP
sudo sed -i "s/$templateIP/$newIP/" /etc/netplan/01-netcfg.yaml

# Change hostname
sed -i "s/$templateHostname/$newHostname/" /etc/hostname
sed -i "s/$templateHostname/$newHostname/" /etc/hosts

# Reboot
reboot
