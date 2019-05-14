echo "add user jsproxy"
groupadd nobody
useradd jsproxy -g nobody --create-home

echo "switch user jsproxy"
su jsproxy
cd ~

CDN=https://raw.githubusercontent.com/EtherDream/jsproxy-bin/dist
GET="curl -s -O "

echo "download jsproxy server ..."
$GET "$CDN/server.tar.br"

echo "download openresty ..."
$GET "$CDN/linux/openresty.tar.br"

echo "download brotli ..."
$GET "$CDN/linux/brotli.gz"

echo "decompress ..."
gunzip brotli.gz
~/brotli -d openresty.tar.br
~/brotli -d server.tar.br

tar xf openresty.tar
tar xf server.tar
rm -f *.tar*

echo "start proxy server ..."
./server/run.sh

echo "done"