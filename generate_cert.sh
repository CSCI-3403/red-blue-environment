name=$1

docker compose run --rm vpn easyrsa build-client-full "$name" nopass
docker compose run --rm vpn ovpn_getclient "$name" > "$name.ovpn"