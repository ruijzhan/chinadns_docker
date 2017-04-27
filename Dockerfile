FROM resin/rpi-raspbian
ARG SHA=LATEST
RUN SHA=${SHA}
RUN apt-get update \
    && apt-get install --no-install-recommends -y git automake curl build-essential \
    && curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > chnroute.txt \
    && mv ./chnroute.txt /root/chnroute.txt \
    && git clone https://github.com/ruijzhan/ChinaDNS.git \
    && cd ChinaDNS \
    && ./autogen.sh \
    && ./configure \
    && make \
    && cp ./src/chinadns /bin/ \
    && cd .. && rm -rf ChinaDNS \
    && apt-get remove -y --purge git automake curl build-essential \
    && apt-get autoremove --purge -y \
    && apt-get remove --purge `apt-mark showauto` \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* 
CMD chinadns -m -v -c /root/chnroute.txt
