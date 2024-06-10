#!/bin/bash

#Defaults
iptables -P INPUT DROP
iptables -P OUTPUT DROP

#Local Network Only
iptables -A INPUT -s 192.168.23.0/24 -j ACCEPT
iptables -A OUTPUT -d 192.168.23.0/24 -j ACCEPT

#METASPLOITABLE
iptables -A INPUT -s 192.168.23.103 -j DROP

#ICMP (Test using ping)
iptables -A INPUT -p ICMP -j ACCEPT
iptables -A OUTPUT -p ICMP -j ACCEPT

#DNS (Test using nslookup)
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT

#SSH (Test by trying to ssh to git@github.com)
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -j ACCEPT

#DCHP (Test by using dhclient)
iptables -A OUTPUT -p udp --sport 68 --dport 67 -j ACCEPT
iptables -A INPUT -p udp --sport 67 --dport 68 -j ACCEPT

#HTTP (Test by using wget)
#iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --sport 80 -j ACCEPT

#HTTP (No incoming only outgoing)
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

#HTTPS (Test by using wget)
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT

#NTP (Test by using ntpdate)
iptables -A OUTPUT -p udp --sport 123 --dport 123 -j ACCEPT
iptables -A INPUT -p udp --sport 123 --dport 123 -j ACCEPT


