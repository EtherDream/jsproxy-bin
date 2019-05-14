#!/usr/bin/env sh

if [[ $EUID != 0 ]]; then
  echo "RUN AS ROOT"
  exit
fi

echo "add user jsproxy"
groupadd nobody
useradd jsproxy -g nobody --create-home

echo "switch user jsproxy"
su jsproxy
cd ~

CDN=https://cdn.jsdelivr.net/gh/etherdream/jsproxy-bin@master/dist/
GET="curl -s -O "

echo "download jsproxy server ..."
$GET "$CDN/server.tar.br"

echo "download openresty ..."
$GET "$CDN/linux/openresty.tar.br"

echo "download brotli ..."
$GET "$CDN/linux/brotli.gz"

echo "decompress ..."
gunzip brotli.gz
chmod +x brotli

~/brotli -d openresty.tar.br
~/brotli -d server.tar.br

tar xf openresty.tar
tar xf server.tar

rm -f *.tar*

echo "start proxy server ..."
./server/run.sh

echo "done"