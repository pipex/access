FROM resin/rpi-raspbian:jessie

MAINTAINER Felipe Lalanne <felipe@lalanne.cl>

ENV DEBIAN_FRONTEND noninteractive
ENV SSID access
ENV PASSWD 12345678
ENV COUNTRY CL

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

ADD root /
ADD templates /opt/access/templates
ADD entrypoint /opt/access/
RUN chmod 755 /opt/access/entrypoint

ENTRYPOINT ["/opt/access/entrypoint"]
