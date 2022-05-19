#!/bin/bash
sudo su -
sudo apt -y update
sudo apt install -y python3
useradd bespin -s /bin/bash -m
echo 'bespin:It1' | chpasswd
echo 'bespin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd


cat > /home/bespin/000-default.conf <<EOF 
<VirtualHost *:80>
   ProxyRequests Off
                          <Proxy *>
                                  Order deny,allow
                                  Allow from all
                          </Proxy>
        ProxyPass / http://${web_lb_name}:8080/
        ProxyPassReverse / http://${web_lb_name}:8080/
</VirtualHost>
EOF


                  