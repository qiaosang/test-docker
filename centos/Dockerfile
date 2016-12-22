FROM centos

MAINTAINER wenjianzhou nihao-wenjian@163.com

# basic settings
ENV TZ=Asia/Shanghai \
    LANG_=zh_CN.UTF-8 \
    PW=root

RUN set -x \
 && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
 && echo ${LANG_} > /etc/locale.conf \
 && echo "root:${PW}" | chpasswd

# basic paths
ENV TOP_HOME=/root
ENV USR_PATH=${TOP_HOME}/usr \
    APP_HOME=${TOP_HOME}/app

RUN echo ${USR_PATH}

RUN mkdir -p ${USR_PATH} ${APP_HOME}

# basic tools
RUN set -x \
 && yum -y install wget unzip \
# && wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
 && yum clean all

# ssh
RUN set -x \
 && yum install -y openssh-server openssh-clients \
 && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
 && yum clean all

EXPOSE 22

# java
ENV JAVA_DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jre/8u111-b14/jre-8u111-linux-x64.rpm" \
    JAVA_HOME=/usr/java/latest

RUN set -x \
 && wget -q --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_DOWNLOAD_URL} -O /tmp/jre.rpm \
 && yum -y install /tmp/jre.rpm \
 && yum clean all && rm -rf /tmp/*

# filebeat
ENV FILEBEAT_DOWNLOAD_URL="https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.1.1-linux-x86_64.tar.gz" \
    FILEBEAT_HOME=${USR_PATH}/filebeat-5.1.1-linux-x86_64

RUN wget -q ${FILEBEAT_DOWNLOAD_URL} -O /tmp/filebeat.tar.gz \
    && tar -xzf /tmp/filebeat.tar.gz -C ${USR_PATH} \
    && rm -rf /tmp/*

COPY files/filebeat/* ${FILEBEAT_HOME}/

# glassfish
ENV GLASSFISH_DOWNLOAD_URL="http://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip" \
    GLASSFISH_HOME=${USR_PATH}/glassfish4 \
    GLASSFISH_DOMAIN=${USR_PATH}/glassfish4/glassfish/domains/domain1 \
    PATH=${PATH}:${USR_PATH}/glassfish4/bin

RUN set -x \
 && wget -q ${GLASSFISH_DOWNLOAD_URL} -O /tmp/glassfish.zip \
 && unzip -o /tmp/glassfish.zip -d ${USR_PATH} \
 && rm -rf /tmp/*

COPY files/glassfish/* ${GLASSFISH_DOMAIN}/config/

EXPOSE 4848 8080 8181


# commands for container
ENV LOG_COLLECT_START="${FILEBEAT_HOME}/filebeat -c ${FILEBEAT_HOME}/filebeat.yml & sleep 3" \
    WEB_SERVER_START="asadmin start-domain && asadmin deploy ${APP_HOME}/${APP_NAME}" \
    WEB_SERVER_STOP="asadmin stop-domain"

CMD ["/usr/sbin/sshd", "-D"]