#!/bin/bash

InitSwift() {
    sed -i "s/KEYSTONE_HOST/${KEYSTONE_HOST}/g" /etc/swift/proxy-server.conf
}

if [ -f "/startup" ]; then
    if !(env | grep -qi SWIFT_NO_INIT); then
        if !(env | grep -qi KEYSTONE_HOST); then
            echo 'KEYSTONE_HOST not provided'
            exit 1
        fi
        InitSwift
    fi

    rm -f /startup
fi

service rsync start
service rsyslog start
service memcached start
chown -R swift:swift /srv/node

sh
