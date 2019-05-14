#!/usr/bin/env sh

if [[ $EUID = 0 ]]; then
  echo "DO NOT RUN AS ROOT"
  exit
fi

GET="curl -s -O "

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