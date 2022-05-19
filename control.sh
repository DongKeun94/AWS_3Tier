#!/bin/bash
sudo su -
sudo apt -y update 
sudo apt install -y ansible
useradd bespin -s /bin/bash -m
echo 'bespin:It1' | chpasswd
echo 'bespin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
cat >> /etc/ansible/hosts << EOD
[web]
10.0.2.12
10.0.12.12
[was]
10.0.3.12
10.0.13.12
EOD
cat > /etc/ansible/ansible.cfg << EOQ
[defaults]
host_key_checking = false
inventory = /etc/ansible/hosts
remote_user = bespin
ask_pass = false
[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false
EOQ
systemctl restart sshd
