#!/bin/bash

credlist=(${USERS//;/ })

for creds in "${credlist[@]}"; do
    userpass=(${creds//:/ })
    user=${userpass[0]}
    pass=${userpass[1]}
    groups=${userpass[@]:2}

    if ! id -u "$user" &> /dev/null; then
        echo "Creating user: $user"
        useradd -mk /etc/skel/ "$user"
        usermod --shell "/bin/bash" "$user"
        echo "$user:$pass" | chpasswd

        for group in $groups; do
            echo "Adding user $user to group $group"
            usermod -a -G $group $user
        done
    else
        echo "User already exists: $user"
    fi
done