set protocols bgp local-as 65001
set protocols bgp 65001 parameters router-id 192.168.0.254
set protocols bgp 65001 address-family ipv4-unicast network 192.168.0.0/16
set protocols bgp 65001 address-family ipv4-unicast redistribute connected
set protocols bgp 65001 neighbor 192.168.6.50 remote-as 65002
set protocols bgp 65001 neighbor 192.168.6.51 remote-as 65002
set protocols bgp 65001 neighbor 192.168.7.50 remote-as 65002
set protocols bgp 65001 neighbor 192.168.7.51 remote-as 65002
set protocols bgp 65001 neighbor 192.168.6.50 password 6ac3ad90c798da30bf60ae1c3a6ad54e
set protocols bgp 65001 neighbor 192.168.6.51 password 6ac3ad90c798da30bf60ae1c3a6ad54e
set protocols bgp 65001 neighbor 192.168.7.50 password 6ac3ad90c798da30bf60ae1c3a6ad54e
set protocols bgp 65001 neighbor 192.168.7.51 password 6ac3ad90c798da30bf60ae1c3a6ad54e
commit
save
exit

show ip bgp summary
show ip route

delete protocols bgp 65001 neighbor 192.168.6.50 password 6ac3ad90c798da30bf60ae1c3a6ad54e
delete protocols bgp 65001 neighbor 192.168.6.51 password 6ac3ad90c798da30bf60ae1c3a6ad54e
delete protocols bgp 65001 neighbor 192.168.7.50 password 6ac3ad90c798da30bf60ae1c3a6ad54e
delete protocols bgp 65001 neighbor 192.168.7.51 password 6ac3ad90c798da30bf60ae1c3a6ad54e