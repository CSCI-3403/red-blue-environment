#!/bin/bash

if [[ -d /etc/my_fs.d ]]; then
    cp -r /etc/my_fs.d /

    for user in $(ls /home); do
        chown -R "$user" "/home/$user/"
        chgrp -R "$user" "/home/$user/"
    done
fi
