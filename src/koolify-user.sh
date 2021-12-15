#!/bin/bash
## (C) 2021
## Ramon Brooker
## rbrooker@aeo3.io

if [[ $1 = 'help' ] || [ $1 = 'HELP']]; then
    cat <<EOF

This tool is used to add extra tools to a user that was created before the bootstrap
user or for updating their current setup.

Usage:
    $ koolify-user username

EOF
    exit 0;
elif [[ $1 = '' ]]; then
    TARGET_USER=${USER}
else
    TAGET_USER=$1
fi

echo "koolify ${TARGET_USER}"
for file in  /etc/skel/.[a-zA-Z-_]*
do
    cp ${file} /home/${TARGET_USER}/
done


if [[ ${USER} = ${TARGET_USER} ]]; then
    echo "now run: "
    echo "$ source ~/.bashrc "
else
    echo "If ${TAGET_USER} is already logged in,  run:"
    echo "$  source ~/.bashrc "
    echo "or just logout and back in again"
fi



exit 0
