FROM debian:8.6

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y libreadline-dev && \
    apt-get install -y transmission-daemon

ADD files/transmission-daemon /etc/transmission-daemon
ADD files/run_transmission.sh /run_transmission.sh

RUN mkdir -p /torrents && \ 
    mkdir -p /torrents/incomplete && \
    mkdir -p /torrents/complete && \ 
    chmod -R 777 /torrents

VOLUME ["/torrents/complete"]
VOLUME ["/torrents/incomplete"]

EXPOSE 9091
EXPOSE 12345

CMD ["/run_transmission.sh"]
