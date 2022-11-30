# These are the steps taken to initialize the OpenVPN volume. It is not necessary to re-run them.
if [[ $# != 1 ]]; then
    echo "Usage: $0 HOSTNAME"
    exit 1
fi

if [[ ! -f files/ssh/id_rsa ]]; then
    ssh-keygen -f files/ssh/id_rsa
fi

function init() {
    dockername="$1"
    hostname="$2"
    port="$3"
    route="$4"

    docker compose run --rm "$dockername" ovpn_genconfig -u "udp://$hostname:$port" -d -r "$route"
    docker compose run --rm "$dockername" ovpn_initpki nopass

}

# init "internal-vpn" "$1" "1194" "10.10.10.0/24"
# init "external-vpn" "$1" "1195"

./generate_cert.sh "internal-vpn" "blueteam"
# ./generate_cert.sh "external-vpn" "redteam"

# For some reason, reading pushed routes from the server also prevents the client from accessing
# sites outside of the VPN. This is probably debuggable, but for time reasons I'm going with the
# easy solution: Block pulled routes and add our own to every client config file. 
echo "route-nopull" >> "blueteam.ovpn"
echo "route 10.10.10.0 255.255.255.0 vpn_gateway" >> "blueteam.ovpn"

# echo "route-nopull" >> "redteam.ovpn"
# echo "route 10.44.44.0 255.255.255.0 vpn_gateway" >> "redteam.ovpn"