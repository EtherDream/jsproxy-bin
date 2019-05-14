#!/usr/bin/env sh

CDN=https://cdn.jsdelivr.net/gh/etherdream/jsproxy-bin@master/dist/
GET="curl -s -O "

echo "download jsproxy server ..."
$GET $CDN/server.tar.br

echo "download openresty ..."
$GET $CDN/linux/openresty.tar.br

echo "download brotli ..."
$GET $CDN/linux/brotli.gz

echo "decompress ..."
gunzip brotli.gz
chmod +x brotli

~/brotli -d openresty.tar.br
~/brotli -d server.tar.br

tar xf openresty.tar
tar xf server.tar

rm -f *.tar*
rm -f setup.sh

echo "start nginx ..."
./server/run.sh

echo "check nginx status ..."
isOK=$(curl -s http://127.0.0.1:8080/ | grep origin)

if [ -z "$isOK" ]; then
  echo "nginx is not running!"
else
  echo "nginx is running"
fi