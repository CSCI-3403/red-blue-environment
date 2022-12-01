# New Hire: Getting Started

## Getting VPN access

Send an email to Alice, the head of IT. She will create an account for you on the VPN, which should give you access to our production servers!

## Maintaining servers

We run four servers:

- web1.hat.biz (10.10.10.6): Public web server #1  
- web2.hat.biz (10.10.10.7): Public web server #2  
- db.hat.biz (10.10.10.8): Database server  
- docs.hat.biz (10.10.10.9): Internal web server hosting these docs  

The web servers run our various internal websites. They all use Apache2, and the files are stored in the usual path of /var/www/html.

The database server stores our data. It runs a mysql database.

The one internal web server is hosting this documentation! It is configured the same as the external servers, but is not available to the internet.

## Getting server access

Any of the servers can be accessed over SSH using these maintenance credentials:

* Username: admin  
* Password: hattitude  

To access the mysql database, you can use the credentials:

* Username: dbadmin  
* Password: dbaccess  

After getting access, we encourage employees to make their own user account.