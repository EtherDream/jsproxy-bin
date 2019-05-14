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

echo "start proxy server ..."
./server/run.sh

echo "done"