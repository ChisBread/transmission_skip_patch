FROM ubuntu:20.04
RUN apt update && apt install -y wget
COPY spks/transmission_x64-6.2.3_3.00-19.spk transmission_x64-6.2.3_3.00-19.spk
RUN mkdir -p /tmp/tr && cd /tmp/tr && cp /transmission_x64-6.2.3_3.00-19.spk . && \
    tar xvf transmission_x64-6.2.3_3.00-19.spk && tar xvf package.tgz && \
    chown -R root:root * && chmod 765 lib/* bin/* && cp bin/* /usr/bin/ && cp -r lib/* /lib/x86_64-linux-gnu/ && \
    cp -r share/transmission /usr/share
COPY start.sh /start.sh
COPY settings.json /settings.json
RUN chmod 765 /start.sh
# ports and volumes
EXPOSE 9091 51413/tcp 51413/udp
VOLUME /config /downloads /watch
CMD [ "/start.sh" ]