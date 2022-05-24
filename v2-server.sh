#!/bin/sh

if [ "${DOMAIN}" = "your.domain.com" ]; then
  echo "未提供域名，开始获取本机IP地址..."
  ipv4=$(v2ctl fetch http://httpbin.org/ip | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
  echo "自动获取到当前机器IP地址："${ipv4}
  DOMAIN=${ipv4}
fi

if [ ! -f "uuid" ]; then
  xray uuid >uuid
  uuid=$(cat uuid)
  xray tls cert --domain=${DOMAIN} >ssl.json
  sed -i '/certificates/r ssl.json' 6in1-server.json
  sed -i 's/443/'${PORT}'/' 6in1-server.json
  sed -i 's/UUID_UUID/'${uuid}'/' 6in1-server.json
  sed -i 's/DOMAIN/'${DOMAIN}'/' v2-server.json
  sed -i 's/your.domain.com/'${DOMAIN}'/' v2-client.json
fi
#echo "vmess://$(base64 -w 0 /srv/v2-client.json)" >url.txt
#url=$(cat url.txt)

echo "



VMess链接：${url}



"

xray run -c /srv/6in1-server.json
