# 记录企业实战的docker文档
> 部分实战例子添加了说明，个别没做详细说明。

## 安装docker

### 添加阿里云源
> 直接使用官方的docker源会比较慢，可选择先添加阿里云进行安装

  * 允许apt通过https使用repository安装软件包
  ```
  apt-get update
  
  apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common
  ```
  * 添加Docker 阿里GPG key
  ```
  curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
  ```
  * 验证key的指纹
  ```
  apt-key fingerprint 0EBFCD88
  ```
  * 添加稳定版repository
  ```
  add-apt-repository \
   "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  ```
  * 更新源
  ```
  apt-get update
  ```
  
### 安装docker
```
apt install docker.io
```
### 修改docker配置
```
vim /etc/docker/daemon.json
```
> 默认无该文件，创建后写入以下信息
```
{
  "registry-mirrors": [
    "https://cy30onzs.mirror.aliyuncs.com",
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
```
### 重启docker
```
systemctl daemon-reload
systemctl restart docker
```

## 安装docker-compose
* 下载安装docker-compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
* 授权docker-compose命令
```
sudo chmod +x /usr/local/bin/docker-compose
```
## docker 常用命令
* 容器生命周期管理 
  * `docker [run|start|stop|restart|kill|rm|pause|unpause]`
* 容器操作运维 
  * `docker [ps|inspect|top|attach|events|logs|wait|export|port]`
* 容器rootfs命令 
  * `docker [commit|cp|diff]`
* 镜像仓库 
  * `docker [login|pull|push|search]`
* 本地镜像管理 
  * `docker [images|rmi|tag|build|history|save|import]`
* 其他命令 
  * `docker [info|version]`
 
* 基本命令实例
``` 
sudo service docker start
sudo service docker stop
sudo service docker restart
docker image ls
docker image pull library/hello-world
docker image rm 镜像id/镜像ID
docker run [选项参数] 镜像名 [命令]
docker container stop 容器名或容器id
docker container start 容器名或容器id
docker container kill 容器名或容器id
docker container rm 容器名或容器id
```

## 其他工具 - ansible
请查阅 https://github.com/huangronaldo/ansible
