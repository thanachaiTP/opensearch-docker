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

## 7. Change default admin password
exec to container and run hash.sh with option -p newpassword 
copy password hash
```
# docker exec -it opensearch-node bash
# /usr/share/opensearch/plugins/opensearch-security/tools/hash.sh -p passw0rd

$2y$12$UrLh1/OG6EhZ8RC27BD5ROOQ.4ioECP7RbE1ILC9vg4bWo0cx6vhS
```

## 8. Edit internal_users.yml
```
# vi /usr/share/opensearch/config/opensearch-security/internal_users.yml
```
Example
```
admin:
  hash: "$2y$12$UrLh1/OG6EhZ8RC27BD5ROOQ.4ioECP7RbE1ILC9vg4bWo0cx6vhS"
  reserved: true
  backend_roles:
  - "admin"
  description: "Demo admin user"

kibanaserver:
  hash: "$2y$12$UrLh1/OG6EhZ8RC27BD5ROOQ.4ioECP7RbE1ILC9vg4bWo0cx6vhS"
```

## 9. Apply security changes
```
# sh /usr/share/opensearch/securityadmin_demo.sh
```

## 10. Exit container opensearch-node
