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

./brotli -d openresty.tar.br
./brotli -d server.tar.br

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


compile_nginx() {
  mkdir -p __install__
  rm -rf __install__/*.gz
  cd __install__

  echo "download pcre ..."
  $GET https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz
  tar zxf pcre-*

  echo "download openssl ..."
  $GET https://www.openssl.org/source/openssl-1.1.1b.tar.gz
  tar zxf openssl-*

  echo "download openresty ..."
  $GET https://openresty.org/download/openresty-1.15.8.1rc2.tar.gz
  tar zxf openresty-*

  cd openresty-*

  export PATH=$PATH:/sbin
  ./configure \
    --with-openssl=../openssl-1.1.1b \
    --with-pcre=../pcre-8.42 \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-pcre-jit \
    --prefix=$HOME/openresty

  make
  make install

  cd ../..
  rm -rf __install__
}


compile_brotli() {
  git clone --depth 1 https://github.com/google/brotli.git
  cd brotli

  make
  mv bin/brotli ~

  cd ..
  rm -rf brotli
}