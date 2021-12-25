FROM ubuntu:20.04
RUN sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list
# 非交互安装,并且删除安装缓存
RUN apt-get update; \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends expect wget ca-certificates; \
    rm -rf /var/lib/apt/lists/*
# 拷贝需要的文件
COPY spks/transmission_x64-6.2.3_3.00-19.spk transmission_x64-6.2.3_3.00-19.spk
ENV TRANSMISSION_WEB_HOME=/usr/share/transmission/web \
    TZ=Asia/Shanghai 
# 安装transmission
RUN mkdir -p /tmp/tr && cd /tmp/tr && cp /transmission_x64-6.2.3_3.00-19.spk . && \
    tar xvf transmission_x64-6.2.3_3.00-19.spk && tar xvf package.tgz && \
    chown -R root:root * && chmod -R 765 lib/ bin/ share/ && cp bin/* /usr/bin/ && cp -r lib/* /lib/x86_64-linux-gnu/ && \
    cp -r share/transmission /usr/share && cd - && rm -rf /tmp/tr
# 安装增强UI
COPY install_webui.sh install_webui.sh
RUN bash install_webui.sh
COPY settings.json /settings.json
# ports and volumes
ENV TR_USER='transmission'
ENV TR_PASS='transmission'
ENV UID=0
ENV GID=0
ENV RPCPORT=9091
ENV PEERPORT=51413
EXPOSE $RPCPORT $PEERPORT/tcp $PEERPORT/udp
VOLUME /config /downloads /watch
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]