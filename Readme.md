# Opensearch Docker

## 0. set sysctl
```
# vim /etc/sysctl.conf
vm.max_map_count=262144

# sysctl -p
```

## 1. git clone 
```
# git clone https://github.com/thanachaiTP/opensearch-docker.git -b opensearch-fluentbit
# cd opensearch-docker
```

## 2. create directory 
```
# mkdir -p opensearch-data && chown -R 1000:1000 opensearch-data
# chown -R 1000:1000 pipeline
```

## 3. run
```
# docker-compose up -d
```

## 4. curl PUT data HTTP request
```
# curl -XPUT -H "Content-Type: application/json" -d ' {"amount": 7, "quantity": 3 }' http://127.0.0.1:5044
```
