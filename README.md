# Network Pentest Exam
A network pentest CTF built in Docker. Students have to use network scanning, password cracking, and packet sniffing to retrieve a number of flags.

**Note: This lab is a work in progress! This README lays out the intended end state of this project, but the current state of the codebase may not include some of these features!**

## Getting started
The docker containers needed to run the lab can be started with `docker compose up -d`.

All traffic to the internal network needs to go through a VPN. This repo contains OpenVPN configs for an admin account, in `admin.ovpn`. Install OpenVPN and import that config file to access the internal network. The containers do not currently have static IP addresses.

The docker containers can be stopped with `docker compose down`. 

## Design
This lab uses Docker Compose to quickly and easily spin up a private network of containers. Each container will represent a unique device on the network, and each one will be given a unique IP.

The network will contain these devices, running services on these ports:
* VPN server
  * Students will use this server to access the rest of the network
  * Port 1194: OpenVPN server which allows students access into the network
* Web server
  * External-facing web server. Contains the fake company's webpage.
  * Port 80: HTTP server
  * Port 443: HTTPS server
  * Port 8088: Development HTTP server
  * Port 21: TELNET server
* Internal web server
  * Internal-facing web server. Contains documentation for "new hires", including sensitive passwords
  * Port 80: HTTP server
* Database server
  * Database server running postgresql
  * Port 5432: Postgresql server
* Alice's laptop
  * Dev laptop, no ports open
* Bob's laptop
  * Dev laptop, no ports open
* CCTV cameras x3
  * Fake "CCTV cameras", each hosting a static image
  * Port 80: HTTP server displaying the "CCTV feed"

## Flags
Flags will be written in the form "{flag-___}", where each one will have a unique value the students will have to discover. Flags will stored in the following places:

* Written on the development website on the web server
  * Students will just need to view the development webpage.
* Inside the postgresql database
  * Students can get the password from the internal documentation site. They will need to read the documentation, find the password to the database, and log in.
* Written on a sticky note in one of the CCTV images
  * The students will simply need to find the CCTV cameras and look on port 80
* Bob's laptop will log into the web server on port 23, using this flag as a password
  * The students will need to use tcpdump to intercept the traffic and read the password
* In a file in Alice's home directory on the web server.
  * The students will need to brute-force Alice's password with John. They will be able to read the /etc/shadow file on the web server.