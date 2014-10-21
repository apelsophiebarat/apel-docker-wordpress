#HOWTO install

```
docker build -t apel-sb-wordpress .

export APPKEY=changeit
export APPSECRET=changeit
export OAUTH_ACCESS_TOKEN=changeit
export OAUTH_ACCESS_TOKEN_SECRET=changeit
export ROOT_PASSWORD=changeit

CID=$(
docker run -d \
-p 80:80 \
-p 1022:22 \
-p 3306:3306 \
-e ROOT_PASSWORD=$ROOT_PASSWORD \
-e APPKEY=$APPKEY \
-e APPSECRET=$APPSECRET \
-e OAUTH_ACCESS_TOKEN=$OAUTH_ACCESS_TOKEN \
-e OAUTH_ACCESS_TOKEN_SECRET=$OAUTH_ACCESS_TOKEN_SECRET \
apel-sb-wordpress)

docker logs -f $CID
```






