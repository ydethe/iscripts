# https://serverfault.com/questions/200635/best-way-to-clear-all-iptables-rules
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X

# Clear ip6tables rules:
sudo ip6tables -P INPUT ACCEPT
sudo ip6tables -P FORWARD ACCEPT
sudo ip6tables -P OUTPUT ACCEPT
sudo ip6tables -t nat -F
sudo ip6tables -t mangle -F
sudo ip6tables -F
sudo ip6tables -X

# https://www.digitalocean.com/community/tutorials/how-to-set-up-an-ikev2-vpn-server-with-strongswan-on-ubuntu-16-04
# To prevent us from being locked out of the SSH session, we’ll accept connections that are already accepted. We’ll also open port 22 (or whichever port you’ve configured) for future SSH connections to the server. Execute these commands:
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# We’ll also need to accept connections on the local loopback interface:
sudo iptables -A INPUT -i lo -j ACCEPT

# Then we’ll tell IPTables to accept IPSec connections:
sudo iptables -A INPUT -p udp --dport  500 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 4500 -j ACCEPT

# Next, we’ll tell IPTables to forward ESP (Encapsulating Security Payload) traffic so the VPN clients will be able to connect. ESP provides additional security for our VPN packets as they’re traversing untrusted networks:
sudo iptables -A FORWARD --match policy --pol ipsec --dir in  --proto esp -s 10.10.10.10/24 -j ACCEPT
sudo iptables -A FORWARD --match policy --pol ipsec --dir out --proto esp -d 10.10.10.10/24 -j ACCEPT

# Our VPN server will act as a gateway between the VPN clients and the internet. Since the VPN server will only have a single public IP address, we will need to configure masquerading to allow the server to request data from the internet on behalf of the clients; this will allow traffic to flow from the VPN clients to the internet, and vice-versa:
sudo iptables -t nat -A POSTROUTING -s 10.10.10.10/24 -o enp3s0 -m policy --pol ipsec --dir out -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 10.10.10.10/24 -o enp3s0 -j MASQUERADE

# To prevent IP packet fragmentation on some clients, we’ll tell IPTables to reduce the size of packets by adjusting the packets’ maximum segment size. This prevents issues with some VPN clients.
sudo iptables -t mangle -A FORWARD --match policy --pol ipsec --dir in -s 10.10.10.10/24 -o enp3s0 -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360

# For better security, we’ll drop everything else that does not match the rules we’ve configured:
sudo iptables -A INPUT -j DROP
sudo iptables -A FORWARD -j DROP

# Now we’ll make the firewall configuration persistent, so that all our configuration work won’t get wiped on reboot:
sudo netfilter-persistent save
sudo netfilter-persistent reload
