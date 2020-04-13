sudo /bin/bash -c 'apt-get update && apt-get -y upgrade && apt-get -y autoremove && if [ -f /var/run/reboot-required ]; then cat /var/run/reboot-required; fi'
