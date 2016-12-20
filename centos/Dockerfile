FROM centos:6.8

MAINTAINER wenjianzhou nihao-wenjian@163.com

# basic settings
ENV TZ=Asia/Shanghai \
    PW=root

RUN set -x \
 && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
 && echo "root:${PW}" | chpasswd

# basic paths
ENV TOP_PATH=/root
ENV USR_PATH=${TOP_PATH}/usr \
    APP_HOME=${TOP_PATH}/app

RUN mkdir -p ${USR_PATH} ${APP_HOME}

# basic tools
RUN set -x \
 && yum -y install wget unzip \
 && yum clean all

# ssh
RUN set -x \
 && yum install -y openssh-server openssh-clients \
 && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
 && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
 && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
 && yum clean all

EXPOSE 22

# jdk
ENV JAVA_DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.rpm" \
    JAVA_HOME=/usr/java/latest

RUN set -x \
 && wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_DOWNLOAD_URL} -O /tmp/jdk.rpm \
 && yum -y install /tmp/jdk.rpm \
 && yum clean all && rm -rf /tmp/*

# logstash
ENV LOGSTASH_DOWNLOAD_URL="https://artifacts.elastic.co/downloads/logstash/logstash-5.1.1.zip"

RUN wget ${LOGSTASH_DOWNLOAD_URL} -O /tmp/logstash.zip \
    && unzip -o /tmp/logstash.zip -d ${USR_PATH} \
    && rm -rf /tmp/*

# glassfish
ENV GLASSFISH_DOWNLOAD_URL="http://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip" \
    GLASSFISH_HOME=${USR_PATH}/glassfish4 \
    GLASSFISH_DOMAIN=${USR_PATH}/glassfish4/glassfish/domains/domain1 \
    PATH=${PATH}:${USR_PATH}/glassfish4/bin

RUN set -x \
 && wget ${GLASSFISH_DOWNLOAD_URL} -O /tmp/glassfish.zip \
 && unzip -o /tmp/glassfish.zip -d ${USR_PATH} \
 && rm -rf /tmp/*

COPY files/glassfish/* ${GLASSFISH_DOMAIN}/config/

EXPOSE 4848 8080 8181

CMD ["/usr/sbin/sshd", "-D"]