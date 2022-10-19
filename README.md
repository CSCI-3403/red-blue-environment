# Network Pentest Exam
A network pentest CTF built using Docker Compose. Students have to use network scanning, password cracking, and packet sniffing to retrieve a number of flags.

## Getting started
### Turning everything on
The docker containers needed to run the lab can be started with `docker compose up -d`.

Currently, the network consists of 9 containers, although only two of them expose external ports: The `external_webserver` container exposes ports 80 and 443 TCP, while the `vpn` container exposes an OpenVPN server on port 1194 UDP. The rest of the containers are only accessable through the VPN.

### Logging in to the VPN
This repo already contains initialized VPN configs to log in as a student, in `student.ovpn`. Install OpenVPN and import that config file to access the internal network.

To create your own VPN configs, delete the existing configs in `volumes/vpn` and use the following commands to initialize new certs:
```
docker compose run --rm vpn ovpn_genconfig -u [your URL]
docker compose run --rm vpn ovpn_initpki
```

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
Flags will be written in the form "{flag#-___}", where each one will have a unique value the students will have to discover. Flags will stored in the following places:


* {flag1} On the internal wiki under 'new hire'
  * Students will need to find the 'new hire' section of the internal wiki.
* {flag2} Bob's password, which is written on a sticky note in one of the CCTV images
  * The students will simply need to find the CCTV cameras and look on port 80.
* {flag3} Alice's laptop will log into the web server on port 23, using this flag as a password
  * The students will need to log on to the webserver with the password found in flag1 or flag2, then use tcpdump to intercept the traffic and read the password.
* {flag4} Inside the .ssh/id_rsa file in any user's home directory
  * They have to log in with any user's password and read the .ssh/id_rsa file
* {flag5} Inside the postgresql database
  * Students can get the password from the internal documentation site. They will need to read the documentation, find the password to the database, and log in.
* {flag6} In a file in Carol's home directory on the web server.
  * The students will need to log on to the webserver using the password found in flag1 or flag2, then brute-force Carol's password with John. They will be able to read the /etc/shadow file on the web server.