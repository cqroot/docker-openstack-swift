FROM         debian:stable-20220125-slim
MAINTAINER   cqroot "cqroot@outlook.com"

ENV          TZ=Asia/Shanghai

COPY         bootstrap.sh /
COPY         etc/sources.list /etc/apt/sources.list
COPY         etc/proxy-server.conf etc/account-server.conf etc/container-server.conf etc/object-server.conf etc/swift.conf /etc/swift/
COPY         etc/rsyslog-swift.conf /etc/rsyslog.d/
COPY         etc/rsyncd.conf /etc/

RUN          apt-get update && \
             apt-get install -y --fix-missing \
                 vim liberasurecode-dev rsync rsyslog memcached python3 python3-pip && \
             pip install -U pip -i https://pypi.tuna.tsinghua.edu.cn/simple && \
             pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple \
                 python-openstackclient==5.7.0 swift==2.29.0 keystonemiddleware==9.4.0 python3-memcached==1.51 python-swiftclient && \
             sed -i 's/^RSYNC_ENABLE=false$/RSYNC_ENABLE=true/g' /etc/default/rsync && \
             groupadd swift && useradd swift -d /home/swift -g swift && \
             mkdir -p /var/cache/swift && \
             chown -R root:swift /var/cache/swift && \
             chmod -R 775 /var/cache/swift && \
             touch /startup

WORKDIR      /root

CMD          ["/bin/sh", "-x", "/bootstrap.sh"]
