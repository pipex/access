Access
======= 

Wireless access point for Raspberry PI. It aims to first to provide a reliable way to reach the Raspbery PI and the Internet wirelessly while at the same allow some protection for the accessing device, specially when navigating on public networks. 

The software provides a web interface for configuration, with a captive portal for easy configuration on mobile devices.

# Setup and running 

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
