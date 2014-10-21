#!/bin/bash
echo "=> Restore Apel wordpress"

start_mysql_server() {
	/usr/bin/mysqld_safe > /dev/null 2>&1 &	
}

wait_for_mysql() {
	RET=1
	while [[ RET -ne 0 ]]; do
	    echo "=> Waiting for confirmation of MySQL service startup"
	    sleep 5
	    mysql -uroot -e "status" > /dev/null 2>&1
	    RET=$?
	done
}

stop_mysql_server() {
	mysqladmin -uroot shutdown
}

echo "=> Download backup"
cat > ~/.dropbox_uploader <<- EOF
APPKEY=$APPKEY
APPSECRET=$APPSECRET
ACCESS_LEVEL=sandbox
OAUTH_ACCESS_TOKEN=$OAUTH_ACCESS_TOKEN
OAUTH_ACCESS_TOKEN_SECRET=$OAUTH_ACCESS_TOKEN_SECRET
EOF

/Dropbox-Uploader/dropbox_uploader.sh download restore

echo "=> Restore content"
rm -rf /app/*
tar --gzip -xf /restore/content.tar.gz -C /app
chown -R www-data:www-data /app /var/www/html

echo "=> Restore database"
start_mysql_server
gunzip /restore/db.sql.gz
wait_for_mysql
mysqladmin -u root --force drop wordpress
mysqladmin -u root create wordpress
mysql -u root wordpress < /restore/db.sql
stop_mysql_server

echo "=> Done"