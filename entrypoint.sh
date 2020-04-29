#!/bin/bash

if [ $(find /etc/mock -maxdepth 0 -empty | wc -l) != 0 ]; then
    echo "/etc/mock is empty, populating it with default configs."
    cp -raT /etc/mock-default /etc/mock
fi

cd /workdir
exec /usr/bin/mock "$@"
