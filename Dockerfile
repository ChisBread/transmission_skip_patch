FROM ubuntu:20.04
RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list
# 非交互安装,并且删除安装缓存
RUN apt-get update; \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends expect wget; \
    rm -rf /var/lib/apt/lists/*
# 拷贝需要的文件
COPY spks/transmission_x64-6.2.3_3.00-19.spk transmission_x64-6.2.3_3.00-19.spk
COPY install_webui.sh install_webui.sh
COPY start.sh /start.sh
COPY settings.json /settings.json
# 安装transmission
RUN mkdir -p /tmp/tr && cd /tmp/tr && cp /transmission_x64-6.2.3_3.00-19.spk . && \
    tar xvf transmission_x64-6.2.3_3.00-19.spk && tar xvf package.tgz && \
    chown -R root:root * && chmod 765 lib/* bin/* && cp bin/* /usr/bin/ && cp -r lib/* /lib/x86_64-linux-gnu/ && \
    cp -r share/transmission /usr/share
# 安装增强UI
RUN bash install_webui.sh
ENV TRANSMISSION_WEB_HOME=/usr/share/transmission/web/transmission-web-control-master/src/
# ports and volumes
RUN chmod 765 /start.sh
EXPOSE 9091 51413/tcp 51413/udp
VOLUME /config /downloads /watch
CMD [ "/start.sh" ]