# Network Pentest Exam
A network pentest CTF built using Docker Compose. Students have to use network scanning, password cracking, and packet sniffing to retrieve a number of flags.

## Getting started
### Turning everything on
The docker containers needed to run the lab can be started with `docker compose up -d`.

Currently, the network consists of 9 containers, although only two of them expose external ports: The `external_webserver` container exposes ports 80 and 443 TCP, while the `vpn` container exposes an OpenVPN server on port 1194 UDP. The rest of the containers are only accessable through the VPN.

### Logging in to the VPN
This repo contains OpenVPN configs for an admin account, in `admin.ovpn`. Install OpenVPN and import that config file to access the internal network.

You can create new VPN accounts using the following commands:
```
docker compose run --rm vpn easyrsa build-client-full <username> nopass
docker compose run --rm vpn ovpn_getclient <username> > <username>.ovpn
```

### Shutting everything down
The docker containers can be stopped with `docker compose down`. 

## Design
This lab uses Docker Compose to quickly and easily spin up a private network of containers. Each container represents a unique device on the network.

The network currently contains these devices:
* 172.16.10.2: VPN server. Students will use this server to access the rest of the network.
  * Port 1194: OpenVPN server
* 172.16.10.4: External-facing web server. Contains the fake company's webpage, and exposes ports to the internet.
  * Port 80: HTTP server
  * Port 443: HTTPS server
  * Port 8088: Development HTTP server
  * Port 21: TELNET server
* 172.16.10.5: Internal-facing web server. Contains documentation for "new hires", including the passwords employees use to log into other servers.
  * Port 80: HTTP server
* 172.16.10.6: Database server. Runs postgresql.
  * Port 5432: Postgresql server
* 172.16.10.100: Alice's developer laptop. No ports are open.
* 172.16.10.101: Bob's developer laptop. No ports are open.
* 172.16.10.200-202: Fake "CCTV cameras". Each one hosts a different static image of the fake "office building".
  * Port 80: HTTP server displaying the "CCTV feed"

## Important Files
### docker-compose.yml
Contains the Docker Compose configuration for each container, including network and volume info.
### docker/
Contains the custom Docker images used for some of the containers.
### volumes/
Contains the data volumes which will be read and modified by some of the containers.

## Flags
Flags will be written in the form "{flag-___}", where each one will have a unique value the students will have to discover. Flags will stored in the following places:

* Written on the development website on the web server
  * Students will just need to view the development webpage.
* Inside the postgresql database
  * Students can get the password from the internal documentation site. They will need to read the documentation, find the password to the database, and log in.
* Written on a sticky note in one of the CCTV images
  * The students will simply need to find the CCTV cameras and look on port 80.
* Bob's laptop will log into the web server on port 23, using this flag as a password
  * The students will need to use tcpdump to intercept the traffic and read the password.
* In a file in Alice's home directory on the web server.
  * The students will need to brute-force Alice's password with John. They will be able to read the /etc/shadow file on the web server.