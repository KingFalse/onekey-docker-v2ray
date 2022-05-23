# onekey-docker-v2ray

**一键部署你的V2ray服务**

### 快速安装

* `curl -sSL https://raw.githubusercontent.com/KingFalse/onekey-docker-v2ray/main/install.sh | bash`

* 因为是自签证书,必须在客户端中将`跳过证书验证(allowInsecure)`选项设置为true

### 查看链接

```
docker exec v2ray cat /srv/url.txt
```

### 完全卸载

```
docker rm -f v2ray
```

### 屏幕预览

![screenshot](screenshot/img.png)

### 其他

有问题提Issues,有需求也可
