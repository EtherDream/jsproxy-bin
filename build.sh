echo "compress server ..."
brotli -f src/server.tar -o dist/server.tar.br

echo "compress brotli ..."
zopfli src/linux/brotli
mv src/linux/brotli.gz dist/linux