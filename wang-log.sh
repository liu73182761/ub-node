#! /bin/bash
#我是笨蛋刘晓陆
if [ "$(id -u)" == "0" ]
then 


 

sleep 1
chmod 777 startup.sh
cd softserver 
chmod 777 softserver
sudo ./softserver start 
sleep 2 
ifconfig tap_pi 192.168.10.1
sudo echo -e "softehter 服务段启动成功"
sudo echo -e "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo echo -e "ip内核转发成功共享上网成功"
sleep 3
apt update -y
apt install isc-dhcp-server isc-dhcp-server-ldap -y
echo -e "dhcpd 安装成功"
sleep 3
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
echo -e "subnet 192.168.10.0 netmask 255.255.255.0 {
  range 192.168.10.50 192.168.10.200;
  option subnet-mask 255.255.255.0;
  option routers 192.168.10.1;

}
option domain-name-servers 8.8.8.8;
default-lease-time 6000000;
max-lease-time 7200000;"  >>/etc/dhcp/dhcpd.conf
sleep 3
service isc-dhcp-server start
echo -e "dhcp服务器启动成功"

sleep 3
apt install rinetd -y
echo -e "rinetd 安装成功"
rm -rf /etc/rinetd.conf
touch /etc/rinetd.conf
echo -e "0.0.0.0 31400 192.168.10.50 31400
         0.0.0.0 31401 192.168.10.50 31401
         0.0.0.0 31402 192.168.10.50 31402
         0.0.0.0 31403 192.168.10.50 31403
         0.0.0.0 31404 192.168.10.50 31404
         0.0.0.0 31405 192.168.10.50 31405
         0.0.0.0 31406 192.168.10.50 31406
         0.0.0.0 31407 192.168.10.50 31407
         0.0.0.0 31408 192.168.10.50 31408
         0.0.0.0 31409 192.168.10.50 31409
         0.0.0.0 31410 192.168.10.50 31410
         logfile /var/log/xiaolu.log" >> /etc/rinetd.conf

rinetd -c /etc/rinetd.conf

#添加开机自动重启服务
chmod 777 /etc/rc.local 
echo -e "/root/ub-node/startup.sh >/tmp/xiaolu.log 2>&1" >>/etc/rc.local
echo -e "服务器架设成功，请验收 我是笨蛋刘晓陆"


else 
echo  "不是root登录无法运行,请用root登录"
fi
