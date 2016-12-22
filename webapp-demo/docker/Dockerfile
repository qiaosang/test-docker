FROM wenjianzhou/centos

MAINTAINER wenjianzhou

RUN echo "root:zytv" | chpasswd

ENV APP_NAME=*.war

COPY /docker/* ./target/${APP_NAME} ${APP_HOME}/

CMD ${APP_HOME}/start.sh