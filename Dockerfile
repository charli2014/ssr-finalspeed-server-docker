FROM ubuntu:trusty

MAINTAINER arctg70 <simon.zhou@gmail.com>
COPY rc.local /etc/rc.local
RUN apt-get update && \
    apt-get install -y --force-yes curl git python && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN curl -sSL https://raw.githubusercontent.com/jonechenug/finalspeed/master/install_fs.sh --output install_fs.sh \
&& chmod +x install_fs.sh \
&& ./install_fs.sh 2>&1 | tee install.log
RUN cd / && \
    git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git && \
    cd /shadowsocksr && \
    bash initcfg.sh 
EXPOSE 150/udp
EXPOSE 8388

ADD start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["sh", "-c", "/start.sh"]

