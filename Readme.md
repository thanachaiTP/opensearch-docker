# Opensearch Docker

## 0. set sysctl
```
# vim /etc/sysctl.conf
vm.max_map_count=262144

# sysctl -p
```

## 1. git clone 
```
# git clone https://github.com/thanachaiTP/opensearch-docker.git
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

## 5. curl POST index
```
# curl -X POST -k -u admin:admin https://127.0.0.1:9200/my-index-000001/_doc/?pretty -H 'Content-Type: application/json' -d'
{
  "@timestamp": "2099-11-15T13:12:00",
  "message": "GET /search HTTP/1.1 200 1070000",
  "user": {
    "id": "kimchy"
  }
}
'
OR
# curl -X POST -k -u admin:admin https://127.0.0.1:9200/my-index-000002/_doc/?pretty -H 'Content-Type: application/json' -d '{"@timestamp": "2099-11-15T13:12:00","message": "GET /search HTTP/1.1 200 1070000","user":"test"}'
```

## 6. curl DELETE index
```
# curl -X DELETE -k -u admin:admin https://127.0.0.1:9200/my-index-000002?pretty
```
