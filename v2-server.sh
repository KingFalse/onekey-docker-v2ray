#!/bin/sh

if [ "${DOMAIN}" = "your.domain.com" ]; then
  echo "您必须输入一个已经解析到当前主机的域名！"
  exit 0
fi

if [ ! -f "uuid" ]; then
  v2ctl uuid >uuid
  uuid=$(cat uuid)
  v2ctl cert -domain=${DOMAIN} --file=${DOMAIN}
  sed -i 's/UUID/'${uuid}'/' v2-server.json
  sed -i 's/DOMAIN/'${DOMAIN}'/' v2-server.json
  sed -i 's/CACA/'${ca}'/' v2-server.json
  sed -i 's/UUID/'${uuid}'/' v2-client.json
  sed -i 's/your.domain.com/'${DOMAIN}'/' v2-client.json
fi
echo "vmess://$(base64 -w 0 /srv/v2-client.json)" >url.txt
url=$(cat url.txt)
echo "



VMess链接：${url}



"

/usr/bin/v2ray -config /srv/v2-server.json
