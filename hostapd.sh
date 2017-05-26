#!/bin/bash

TPL=${TPL:-"/tpl"}

# Evaluate template with environment variables
function template {
    function process {
        while read -r line ; do
            while [[ "$line" =~ (\$\{[a-zA-Z_][a-zA-Z_0-9]*\}) ]] ; do
                LHS=${BASH_REMATCH[1]}
                RHS="$(eval echo "\"$LHS\"")"
                line=${line//$LHS/$RHS}
            done
            echo "$line"
        done
    }

    process < $1 
}

# For each template in the directory, replace 
# the environment variables
for tpl in `find ${TPL} -type f` ;
do
    dst=${tpl//${TPL}/} 
    template $tpl > $dst
done

# Add the interface uap0 to the main interface as ap
iw dev wlan0 interface add uap0 type __ap

# Start dnsmaq
service dnsmasq restart

# Allow ipv4 forwarding
sysctl net.ipv4.ip_forward=1

# Update iptables ruls
iptables -t nat -A POSTROUTING -s 192.168.50.0/24 ! -d 192.168.50.0/24 -j MASQUERADE

# Laod interface 
ifup uap0

# Run hostapd
hostapd /etc/hostapd/hostapd.conf
