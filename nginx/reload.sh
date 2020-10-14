#!/bin/bash
docker exec -it `docker ps -a |grep nginx |awk '{print $1}'` nginx -s reload
