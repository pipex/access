FROM resin/rpi-raspbian:jessie

MAINTAINER Felipe Lalanne <felipe@lalanne.cl>

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb http://archive.raspbian.org/raspbian jessie main contrib non-free" > /etc/apt/sources.list

# AP stuff
RUN apt-get update && apt-get -q -y install \
        hostapd \
        ifupdown \
        iw \
        iptables \
        dnsmasq \
        wpasupplicant \
        && apt-get clean

ADD rootdir /
ADD templates /opt/access/templates
ADD access-start /opt/access/
RUN chmod 755 /opt/access/access-start

ENTRYPOINT ["/opt/access/access-start"]
