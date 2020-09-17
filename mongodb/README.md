## 部署MongoDB副本集群
### 环境准备
* 安装docker，安装docker-compose
* 生产环境最好是将不同的节点部署在不同的服务器上

### 生成keyFile
* MongoDB使用keyfile认证，副本集中的每个mongod实例使用keyfile内容作为认证其他成员的共享密码。mongod实例只有拥有正确的keyfile才可以加入副本集。
* keyFile的内容必须是6到1024个字符的长度，且副本集所有成员的keyFile内容必须相同。
* 有一点要注意是的：在UNIX系统中，keyFile必须没有组权限或完全权限（也就是权限要设置成X00的形式）。Windows系统中，keyFile权限没有被检查。
* 可以使用任意方法生成keyFile。例如，如下操作使用openssl生成复杂的随机的1024个字符串。然后使用chmod修改文件权限，只给文件拥有者提供读权限。
这是MongoDB官方推荐keyFile的生成方式：
```
# 400权限是要保证安全性，否则mongod启动会报错
openssl rand -base64 756 > mongodb.key
chmod 400 mongodb.key
```
* 每一个副本集成员都要使用相同的keyFile文件

