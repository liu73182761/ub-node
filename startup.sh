#！ /bin/bash
sudo /root/ub-node/softserver/softserver start 
sleep 3
sudo ifconfig tap_pi 192.168.10.1

sleep 2
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sleep 2
sudo service isc-dhcp-server start
sleep 2
sudo rinetd -c /etc/rinetd.conf