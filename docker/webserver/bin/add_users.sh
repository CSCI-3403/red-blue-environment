#!/bin/bash

split=(${1//;/ })

for creds in "${split[@]}"; do
    userpass=(${creds//:/ })
    user=${userpass[0]}
    pass=${userpass[1]}

    echo "Creating user: $user"
    useradd -mk /etc/skel/ "$user"
    usermod --shell "/bin/bash" "$user"
    echo "$user:$pass" | chpasswd

    echo "Inserting private key flag"
    mkdir "/home/$user/.ssh"
    ssh-keygen -b 2048 -t rsa -f "/home/$user/.ssh/id_rsa" -q -N ""
    echo "{flag4-pr1v4tek3y}" > "/home/$user/.ssh/id_rsa"
    chown -R "$user" "/home/$user/.ssh"
    chgrp -R "$user" "/home/$user/.ssh"
done