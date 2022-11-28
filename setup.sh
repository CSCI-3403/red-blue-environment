# These are the steps taken to initialize the OpenVPN volume. It is not necessary to re-run them.
ssh-keygen -f files/ssh/id_rsa

function init() {
    dockername="$1"
    hostname="$2"
    port="$3"

    docker compose run --rm "$dockername" ovpn_genconfig -d -u "udp://$hostname:$port"
    docker compose run --rm "$dockername" ovpn_initpki nopass

}

if [[ $# != 2 ]]; then
    echo "Usage: $0 HOSTNAME"
    exit 1
fi

init "internal-vpn" "$1" "1194"
init "external-vpn" "$1" "1195"