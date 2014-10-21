#!/bin/sh

#mkdir /restore

echo "=> Install curl"
sudo apt-get install -y curl

echo "=> Install dropbox uploader"
git clone https://github.com/andreafabrizi/Dropbox-Uploader/ /restore/dropboxUploader

cat > /restore/dropbox_uploader_config << EOF
APPKEY=$APPKEY
APPSECRET=$APPSECRET
ACCESS_LEVEL=sandbox
OAUTH_ACCESS_TOKEN=8piji9dpmbgzz4ld
OAUTH_ACCESS_TOKEN_SECRET=uu7ws57h363jo8z
EOF

cat /restore/dropbox_uploader_config

echo "=> download $RESTORE_DATE from dropbox"
/restore/dropboxUploader/dropbox_uploader.sh -f /restore/dropbox_uploader_config download $RESTORE_DATE /restore

echo "=> unzip /restore/$RESTORE_DATE/db.sql.gz"
gunzip /restore/$RESTORE_DATE/db.sql.gz

echo "=> restore wordpress content"
rm -rf /app/*
tar --gzip -xf /restore/$RESTORE_DATE/content.tar.gz -C /app
chown -R www-data:www-data /app/wp-content /var/www/html

echo "=> Restore database content from $RESTORE_DATE"

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

mysqladmin -u root --force drop $DB_NAME
mysqladmin -u root create $DB_NAME
mysql -u root $DB_NAME < /restore/$RESTORE_DATE/db.sql

mysqladmin -uroot shutdown

echo "=> Done!"

touch $VOLUME_HOME/.restored
