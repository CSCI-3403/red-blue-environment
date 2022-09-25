# Network Pentest Exam
A network pentest CTF built in Docker. Students have to use network scanning, password cracking, and packet sniffing to retrieve a number of flags.

**Note: This lab is a work in progress! This README lays out the intended end state of this project, but the current state of the codebase may not include some of these features!**

## Design
This lab uses Docker Compose to quickly and easily spin up a private network of containers. Each container will represent a unique device on the network, and each one will be given a unique IP.

The network will contain these devices, running services on these ports:
* Router
  * Port 443 (external): OpenVPN server which allows students access into the network. This is the only port which should be available to the outside world.
* Web server
  * Port 80: HTTP server
  * Port 443: HTTPS server
  * Port 8088: Development HTTP server
  * Port 21: TELNET server
* Alice laptop
* Bob laptop
* CCTV cameras x3
  * Port 80: HTTP server hosting a static image from a fake "CCTV camera"

## Flags
Flags will be written in the form "{flag-___}", where each one will have a unique value the students will have to discover. Flags will stored in the following places:

* Writton on the development website on the web server
  * Students will need to use a larger port scan than the default nmap one
* Written on a sticky note in one of the CCTV images
  * The students will simply need to find the CCTV cameras and look on port 80
* Bob's laptop will log into the web server on port 23, using this flag as a password
  * The students will need to use tcpdump to intercept the traffic and read the password
* In a file in Alice's home directory on the web server.
  * The students will need to brute-force Alice's password with John. They will be able to read the /etc/shadow file on the web server.