echo "compress brotli ..."
zopfli src/brotli
mv src/brotli.gz dist

echo "compress server ..."
brotli -f src/server.tar -o dist/server.tar.br