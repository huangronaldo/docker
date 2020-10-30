### 常见问题
#### 问题一：
* 问题：Redis is configured to save RDB snapshots, but it is currently not able to persist on disk。
* 原因：因为强制把redis快照关闭了导致不能持久化的问题，修改stop-writes-on-bgsave-error no
* 解决方案：一种通过redis命令行修改，一种修改redis.conf配置文件。命令行：`config set stop-writes-on-bgsave-error no`
