#!/bin/bash

credlist=(${USERS//;/ })

for creds in "${credlist[@]}"; do
    userpass=(${creds//:/ })
    user=${userpass[0]}
    pass=${userpass[1]}

    echo "Creating user: $user"
    useradd -mk /etc/skel/ "$user"
    usermod --shell "/bin/bash" "$user"
    echo "$user:$pass" | chpasswd
done