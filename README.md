
docker build -t apel-sb-wordpress .

docker run -d -p 80:80 -p 1022:22 -p 3306:3306 -e ROOT_PASSWORD=foobar -e APPKEY=u5q2rly67k9pp6e -e APPSECRET=zdnye99m8ze3kmo apel-sb-wordpress

-e MYSQL_PASS=changeit

ssh root@192.168.59.103 -p 1022

mysql -uroot

CREATE USER 'evantill'@'%' IDENTIFIED BY 'foobar';

GRANT ALL PRIVILEGES ON *.* TO 'evantill'@'%' WITH GRANT OPTION;






