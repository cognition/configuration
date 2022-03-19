#!/bin/bash

## Setup Wireguard Server


if [[  -s /etc/wireguard/private.key ]]; then
    echo "Keys already Exist"
    while true
    do
        read -n 1 -t 5 -p "Would you like to re-generate the key pair? (y/n) [N] " REGEN
        case "${REGEN}" in
           [yY]|[nN] )
            break
            ;;
            *)
            echo "please use y or n"
            ;;
    esac
done
else
    REGEN='y'
fi
if [[ ${REGEN} = 'y'  ]]; then
    echo "Create Keys"
    cd /etc/wireguard/
    (umask 077 && wg genkey > private.key)
    wg pubkey < private.key > public.key
fi



PRVT_KEY=$(cat private.key)
ADDRESS_WITH_CIDR='10.0.0.25/6'
IFACE="eth0"
cat > /etc/wireguard/wg0-test <<EOF
# Generated by wg-server-setup
[Interface]

Address = ${ADDRESS_WITH_CIDR}
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ${IFACE} -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ${IFACE} -j MASQUERADE
ListenPort = 51820
PrivateKey = ${PRVT_KEY}

EOF

ls /etc/wireguard/