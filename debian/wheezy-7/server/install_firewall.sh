#!/bin/sh

# Vider les tables actuelles
#sudo iptables -t filter -F
sudo iptables -F

# Vider les règles personnelles
#sudo iptables -t filter -X
sudo iptables -X

# Interdire toute connexion entrante et sortante
sudo iptables -t filter -P INPUT DROP
sudo iptables -t filter -P FORWARD DROP
sudo iptables -t filter -P OUTPUT DROP

# ---

# Ne pas casser les connexions etablies
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Autoriser loopback
sudo iptables -t filter -A INPUT -i lo -j ACCEPT
sudo iptables -t filter -A OUTPUT -o lo -j ACCEPT

# ICMP (Ping)
sudo iptables -t filter -A INPUT -p icmp -j ACCEPT
sudo iptables -t filter -A OUTPUT -p icmp -j ACCEPT

# ---

# SSH In
sudo iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT

# SSH Out
sudo iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

# DNS In/Out
sudo iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
sudo iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT

# NTP Out
sudo iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

# HTTP + HTTPS Out
sudo iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

# HTTP + HTTPS In
sudo iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 8443 -j ACCEPT

# FTP Out
sudo iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 989:990 -j ACCEPT

# FTP In
#modprobe ip_conntrack_ftp # ligne facultative avec les serveurs OVH
sudo iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 989:990 -j ACCEPT
sudo iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Mail SMTP:25
sudo iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT

# Mail SMTP 465
sudo iptables -t filter -A INPUT -p tcp --dport 465 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 465 -j ACCEPT

# Mail SMTPS 587
sudo iptables -t filter -A INPUT -p tcp --dport 587 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 587 -j ACCEPT

# Mail POP3:110
sudo iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT

# Mail IMAPS:143
sudo iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT

# Mail IMAP:993
sudo iptables -t filter -A INPUT -p tcp --dport 993 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 993 -j ACCEPT

# Mail POP3S:995
sudo iptables -t filter -A INPUT -p tcp --dport 995 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT

# Git protocole 9418
sudo iptables -t filter -A INPUT -p tcp --dport 9418 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 9418 -j ACCEPT
sudo iptables -t filter -A INPUT -p udp --dport 9418 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p udp --dport 9418 -j ACCEPT

sudo apt-get install iptables-persistent fail2ban

