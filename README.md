# 记录本人在企业实战的docker文档

## 安装docker

* 使用阿里云源进行安装
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
  
* 安装docker
```
apt install docker.io
```
* 修改docker配置
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
* 重启docker
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
* 容器生命周期管理 — `docker [run|start|stop|restart|kill|rm|pause|unpause]`
* 容器操作运维 — `docker [ps|inspect|top|attach|events|logs|wait|export|port]`
* 容器rootfs命令 — `docker [commit|cp|diff]`
* 镜像仓库 — `docker [login|pull|push|search]`
* 本地镜像管理 — `docker [images|rmi|tag|build|history|save|import]`
* 其他命令 — `docker [info|version]`

## docker 部署应用
### elk
elk实现单机elasticsearch集群，通过客户端filebeat采集传输日志文件，logstash分析，最终写入elasticsearch；kibana可视化查看日志。目前已经支持上百台客户端机器日志上传，服务器端机器配置为8核16G。

#### elasticsearch集群

#### logstash

#### kibana

### filebeat

### jenkins
jenkins集成ansible-tower / gitlab，实现企业自动化部署

### sonar
sonar结合jenkins对代码进行质量扫描与分析

### 其他工具 - ansible
请查阅 https://github.com/huangronaldo/ansible
