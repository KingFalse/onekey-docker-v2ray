#!/bin/bash
set -e

PORT=$1
if [[ -z "$1" ]]; then
  PORT=443
fi

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

install_v2ray() {
  echo "正在清理旧容器以及镜像..."
  if [ "$(docker ps -aq -f name=v2ray)" ]; then
    docker rm -f v2ray >/dev/null 2>&1
  fi
  echo "您指定的端口是：${PORT}"
  echo "正在获取本机IP地址..."
  ipv4=$(curl -sSL http://httpbin.org/ip | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
  echo "获取到当前机器IP地址："${ipv4}
  DOMAIN=${ipv4}
  echo "正在启动docker容器..."
  docker run --name v2ray -d --restart=always --pull=always -p ${PORT}:${PORT} -e PORT=${PORT} -e DOMAIN=${DOMAIN} kingfalse/onekey-docker-v2ray
  echo ""
  echo ""
  docker exec v2ray cat /srv/url.txt
  echo ""
  echo ""
  echo "注意！！！"
  echo "因为是自签证书,必须在客户端中将跳过证书验证(allowInsecure)选项设置为true"
  echo "因为是自签证书,必须在客户端中将跳过证书验证(allowInsecure)选项设置为true"
  echo "因为是自签证书,必须在客户端中将跳过证书验证(allowInsecure)选项设置为true"
  echo ""
  echo "完全卸载：docker rm -f v2ray"
  echo "查看链接：docker exec v2ray cat /srv/url.txt"
  echo "喜欢请给个星：https://github.com/KingFalse/onekey-docker-v2ray"
}

do_install() {
  if [ "$EUID" -ne 0 ]; then
    echo "请使用root权限重新执行本脚本..."
    exit
  fi

  if command_exists docker && [ -e /var/run/docker.sock ]; then
    echo "本机已安装docker..."
  else
    echo "正在安装docker..."
    curl -sSL https://get.docker.com/ | bash
  fi

  if command_exists docker && [ -e /var/run/docker.sock ]; then
    systemctl enable docker.service
    systemctl enable containerd.service
    systemctl start docker
    install_v2ray
  else
    echo "docker似乎安装失败，您可自行安装docker并重新运行本脚本"
  fi
}

do_install
