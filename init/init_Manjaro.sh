#!/bin/bash


# 开机启动
systemctl enable sshd.service
# 立即启动
systemctl start sshd.service
# 立即重启
systemctl restart sshd.service

# touch /etc/iptables/iptables.rules
systemctl enable iptables
systemctl start iptables
systemctl enable iptables.service
systemctl start iptables.service

iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
iptables-save > /etc/iptables/iptables.rules

sudo pacman -S chromium
sudo pacman -S tree cloc autojump tmux htop dos2uni
sudo pacman -S net-tools dnsutils inetutils iproute2x

