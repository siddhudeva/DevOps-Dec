#!/bin/bash

USER=$(id -u)

if [ $USER -ne 0 ]; then
   echo "USED SHOULD BE A ROOT USER TO PERFORM THIS"
   exit 
fi
rm -rf /tmp/ansible.log
touch /tmp/ansible.log


yum install updates -y &>>/tmp/ansible.log
echo -e "\e[1;33m updating localcache\e[0m"

yum install -y python3 &>>/tmp/ansible.log
echo -e "\e[1;33m installing py thon\e[0m"

yum install ansible -y &>>/tmp/ansible.log
echo -e "\e[1;33m installing ansible\e[0m"

echo bye