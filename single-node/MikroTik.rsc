# 2025-08-27 12:15:24 by RouterOS 7.15.3
# software id = AT72-51NK
#
/interface ethernet
set [ find default-name=ether1 ] comment=mircocloud disable-running-check=no
set [ find default-name=ether2 ] comment=INET disable-running-check=no

/interface vlan
add interface=ether1 name="vlan100 - vm-test" vlan-id=100
add interface=ether1 name="vlan101 - andre" vlan-id=101

/ip pool
add name=dhcp_pool0 ranges=10.10.100.2-10.10.100.6
add name=dhcp_pool1 ranges=10.10.100.10
add name=dhcp_pool2 ranges=192.168.10.2
/ip dhcp-server
add address-pool=dhcp_pool0 interface="vlan100 - vm-test" name=dhcp1
add address-pool=dhcp_pool1 interface="vlan101 - andre" name=dhcp2
add address-pool=dhcp_pool2 interface=ether1 name=dhcp3
/ip address
add address=10.10.100.1/29 interface="vlan100 - vm-test" network=10.10.100.0
add address=192.168.10.1/30 interface=ether1 network=192.168.10.0
add address=10.10.100.9/30 interface="vlan101 - andre" network=10.10.100.8
/ip dhcp-client
add interface=ether2
/ip dhcp-server network
add address=10.10.100.0/29 gateway=10.10.100.1
add address=10.10.100.8/30 gateway=10.10.100.9
add address=192.168.10.0/30 gateway=192.168.10.1
/ip firewall nat
add action=masquerade chain=srcnat
/system identity
set name=MikroTik
