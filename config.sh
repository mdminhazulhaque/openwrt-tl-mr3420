#!/bin/sh

# Copy my SSH pubkey
echo $__key__ >> /etc/dropbear/authorized_keys

# Set hostname and timezone
uci set system.@system[-1].hostname='router'
uci set system.@system[-1].timezone='BDT-6'

# Set eth2 as wan iface, configure MTU
uci set network.wan.ifname='eth2'
uci set network.wan.mtu='1400'
uci set network.wan.proto='dhcp'

# Enable radio, setup SSID and password
uci set wireless.radio0.disabled='0'
uci set wireless.radio0.hwmode='11bgn'
uci set wireless.@wifi-iface[-1].ssid="$__ssid__"
uci set wireless.@wifi-iface[-1].encryption='psk'
uci set wireless.@wifi-iface[-1].key="$__passwd__"

# Google DNS
uci set dhcp.@dnsmasq[-1].server='8.8.8.8 8.8.4.4'

# Static lease for DHCP
uci add dhcp host
uci set dhcp.@host[-1].name='desktop'
uci set dhcp.@host[-1].ip='192.168.1.100'
uci set dhcp.@host[-1].mac='94:de:80:2b:81:a9'

uci add dhcp host
uci set dhcp.@host[-1].name='phone'
uci set dhcp.@host[-1].ip='192.168.1.101'
uci set dhcp.@host[-1].mac='08:ee:8b:8c:28:6b'

uci add dhcp host
uci set dhcp.@host[-1].name='macbookair'
uci set dhcp.@host[-1].ip='192.168.1.102'
uci set dhcp.@host[-1].mac='9c:f3:87:b3:ee:50'

uci add dhcp host
uci set dhcp.@host[-1].name='tab'
uci set dhcp.@host[-1].ip='192.168.1.103'
uci set dhcp.@host[-1].mac='4c:a5:6d:24:24:bd'

# IP to Domain mapping
uci add dhcp domain
uci set dhcp.@domain[-1].name='desktop'
uci set dhcp.@domain[-1].ip='192.168.1.100'

uci add dhcp domain
uci set dhcp.@domain[-1].name='phone'
uci set dhcp.@domain[-1].ip='192.168.1.101'

uci add dhcp domain
uci set dhcp.@domain[-1].name='macbookair'
uci set dhcp.@domain[1].ip='192.168.1.102'

uci add dhcp domain
uci set dhcp.@domain[-1].name='tab'
uci set dhcp.@domain[-1].ip='192.168.1.103'

# Save everything
uci commit

# Annoying banner when logging in via Telnet/SSH
rm -f /etc/banner.*

# Reboot
reboot
