FROM wenjianzhou/centos

MAINTAINER wenjianzhou

RUN echo "root:zytv" | chpasswd

ENV APP_NAME=*.war

COPY ./docker/* ./target/${APP_NAME} ${APP_HOME}/

RUN mkdir ~/.ssh/ && touch ~/.ssh/authorized_keys \
 && cat ${APP_HOME}/authorized_keys >> ~/.ssh/authorized_keys \
 && chmod 600 ~/.ssh/authorized_keys

CMD ${APP_HOME}/start.sh