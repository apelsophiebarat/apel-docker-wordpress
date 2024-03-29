#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini        
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Create Admin User ..."  
    /create_mysql_admin_user.sh
    echo "=> Create Admin User ..."  
    echo "=> Done!"  
else
    echo "=> Using an existing volume of MySQL"
fi

if [[ ! -f /.restored ]]; then
    /restore_apel_wordpress.sh
    touch /.restored
else 
    echo "=> Apel wordpress site data are already uploaded."
fi

exec supervisord -n