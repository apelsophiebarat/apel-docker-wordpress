#!/bin/sh
echo "=> Install curl,gzip"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl gzip

echo "=> Install dropbox uploader"
git clone https://github.com/andreafabrizi/Dropbox-Uploader 2>&1

echo "=> Done"