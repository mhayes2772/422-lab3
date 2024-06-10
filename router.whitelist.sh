#!/bin/bash

#DNS
iptables -t nat -A PREROUTING -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -t nat -A PREROUTING -p udp --dport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -p udp --sport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

#HTTP
iptables -t nat -A PREROUTING -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

#HTTPS
iptables -t nat -A PREROUTING -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

#NTP
iptables -t nat -A PREROUTING -p udp --sport 123 --dport 123 -m state --state ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -p udp --sport 123 --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT

#Defaults
iptables -t nat -A PREROUTING -j DROP
iptables -t nat -A POSTROUTING -j DROP


