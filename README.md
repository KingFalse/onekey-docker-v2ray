# onekey-docker-v2ray

**一键部署你的V2ray服务**

### 快速安装
首先ssh登陆你的VPS主机并切换到root用户安装Docker,官方一键安装脚本:`curl -sSL https://get.docker.com/ | sh`或者`curl -sSL https://get.docker.com/ | bash`

然后执行`docker run --name v2ray -d -p 443:443 -e PORT=443 kingfalse/onekey-docker-v2ray && sleep 5s && docker logs v2ray` 即可安装完成,并输出VMess链接

因为是自签证书,必须在客户端中将`跳过证书验证(allowInsecure)`选项设置为true

### 完全卸载
```
docker stop v2ray
docker rm v2ray
```
### 其他
有问题提Issues
