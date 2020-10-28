# Docker image for keepalived + nginx
# VERSION 1.0.0
# Author: huangt
# 基础镜像使用nginx 1.18
FROM nginx:1.18.0-alpine
# 作者
MAINTAINER huangt <huangronaldo@qq.com>

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/sfhare/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk update && apk upgrade

RUN apk add --no-cache bash curl ipvsadm iproute2 openrc keepalived && \
    rm -f /var/cache/apk/* /tmp/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
