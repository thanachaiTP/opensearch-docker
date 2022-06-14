#!/bin/bash

echo "--- Create Directory ---"

mkdir -p opensearch-data && chown -R 1000:1000 opensearch-data
chown -R 1000:1000 securityconfig

ls -l

echo -e "\n"

echo "--- Starting Kong ---"
docker-compose up -d kong

STATUSKONG="starting"
while [ "$STATUSKONG" != "healthy" ]
do
    STATUSKONG=$(docker inspect --format {{.State.Health.Status}} kong-9200)
    echo "kong state = $STATUSKONG"
    sleep 5
done

echo -e "\n"

echo "--- Starting Opensearch Node ---"

docker-compose up -d opensearch-node

STATUS="starting"
while [ "$STATUS" != "healthy" ]
do
    STATUS=$(docker inspect --format {{.State.Health.Status}} opensearch-node)
    echo "opensearch-node state = $STATUS"
    sleep 5
done

echo -e "\n"

echo "--- Starting Opensearch Dashboard ---"
docker-compose up -d opensearch-dashboards

echo -e "\n"

echo "--- Starting Fluentbit ---"
docker-compose up -d fluent-bit
echo -e "\n"

echo "--- Starting Zipkin ---"
docker-compose up -d zipkin

STATUSZIPKIN="starting"
while [ "$STATUSZIPKIN" != "healthy" ]
do
    STATUSZIPKIN=$(docker inspect --format {{.State.Health.Status}} zipkin)
    echo "zipkin state = $STATUSZIPKIN"
    sleep 5
done

echo -e "\n"

echo "--- docker-compose ps ---"
docker-compose ps

echo -e "\n"
echo "--- URL ---"
echo "--- Opensearch URL ---"
echo http://$(curl -s ifconfig.io):9200
echo "--- Opensearch Dashboard URL ---"
echo http://$(curl -s ifconfig.io):5601
echo "--- Zipkin URL ---"
echo http://$(curl -s ifconfig.io):9411

echo "--- Kong plugin Zipkin (Jaeger) ---"
echo http://$(curl -s ifconfig.io):9411/api/v2/spans
echo -e "\n"
