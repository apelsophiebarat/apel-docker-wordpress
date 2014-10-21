#!/bin/sh
echo "=> Install curl"
sudo apt-get install -y curl

echo "=> Install dropbox uploader"
git clone https://github.com/andreafabrizi/Dropbox-Uploader

cat > ~/.dropbox_uploader <<- EOF
APPKEY=u5q2rly67k9pp6e
APPSECRET=$APPSECRET
ACCESS_LEVEL=sandbox
OAUTH_ACCESS_TOKEN=8piji9dpmbgzz4ld
OAUTH_ACCESS_TOKEN_SECRET=uu7ws57h363jo8z
EOF

echo "=> Done"