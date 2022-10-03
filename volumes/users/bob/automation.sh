#!/usr/bin/sh

while true
do
    /usr/bin/expect /usr/local/automation/telnet.expect "172.16.10.4" "bob" "{flag-Sw0rdf1sh}"
    sleep 20
done
