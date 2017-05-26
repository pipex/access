Hostapd
======= 

Hostapd is a dockerizable hostapd access point for the Raspberry PI 3. It uses the [capabilities of the RPI3](http://imti.co/post/145442415333/raspberry-pi-3-wifi-station-ap) wireless card to configure the card both as access point and wlan client

## Setup and running 

The software uses docker for easy configuration. To build the docker file just run

```
docker build -t access .
```

The docker image requires privileged access to run and access to the host network configuration. To run the image execute

```
docker run -ti --net="host" --rm --privileged \
    --name access \
    -v /etc/network/interfaces:/etc/network/interfaces \
    -v /etc/hosts:/etc/hosts \
    -e SSID=ssidName \ 
    -e PASSWD=passwd \
    access
```
