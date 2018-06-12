FROM debian:stretch-slim

RUN apt update && \
    apt install -y unbound dnsutils vim net-tools procps && \
    rm -rf /var/lib/apt/lists/* 

# install DNS configuration
COPY conf/etc/unbound/unbound.conf.d/* /etc/unbound/unbound.conf.d/

#update the DNS root keys
RUN unbound-anchor ; true


EXPOSE 53
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/unbound", "-c", "/etc/unbound/unbound.conf" ] 
