FROM resin/rpi-raspbian:jessie

MAINTAINER Felipe Lalanne <felipe@lalanne.cl>

RUN echo "deb http://archive.raspbian.org/raspbian jessie main contrib non-free" > /etc/apt/sources.list
RUN echo "deb-src http://archive.raspbian.org/raspbian jessie main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
	net-tools \
	wireless-tools \
	&& apt-get clean

# AP stuff
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
	hostapd \
    ifupdown \
	iw \
    iptables \
	dnsmasq \
	wpasupplicant \
	&& apt-get clean


ADD config /
# COPY hostapd.conf /etc/hostapd/hostapd.conf
# COPY hostapd /etc/default/hostapd
# COPY hostapdstart /usr/local/bin/
# RUN chmod 755 /usr/local/bin/hostapdstart
# COPY dnsmasq.conf /etc/dnsmasq.conf

ENTRYPOINT ["/usr/local/bin/hostapdstart"]
