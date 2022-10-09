name=$1

echo "Calling build_client.expect"
expect build_client.expect "$name"

# For some reason, reading pushed routes from the server also prevents the client from accessing
# sites outside of the VPN. This is probably debuggable, but for time reasons I'm going with the
# easy solution: Block pulled routes and add our own to every client config file. 
cat <<EOT >> "$name.ovpn"
route-nopull
route 172.16.10.4 255.255.255.255 vpn_gateway
route 172.16.10.5 255.255.255.255 vpn_gateway
route 172.16.10.6 255.255.255.255 vpn_gateway
route 172.16.10.121 255.255.255.255 vpn_gateway
route 172.16.10.122 255.255.255.255 vpn_gateway
route 172.16.10.223 255.255.255.255 vpn_gateway
route 172.16.10.224 255.255.255.255 vpn_gateway
route 172.16.10.225 255.255.255.255 vpn_gateway
EOT

docker compose run --rm vpn ovpn_getclient "$name" >> "$name.ovpn"