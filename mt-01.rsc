# feb/02/2023 14:34:56 by RouterOS 7.7
# software id = 
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-client
add interface=ether1
/system identity
set name=mt-01
