#!/bin/bash
# 停止stop docker nginx
docker stop  `docker ps -a |grep nginx |awk '{print $1}'`
# 启动start docker nginx
docker start `docker ps -a |grep nginx |awk '{print $1}'`
