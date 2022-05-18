#!/bin/bash

echo "--- Create Directory ---"

mkdir -p opensearch-data && chown -R 1000:1000 opensearch-data
chown -R 1000:1000 pipeline

ls -l

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

echo "--- Starting Logstash OSS ---"
docker-compose up -d logstash
echo -e "\n"

echo "--- docker-compose ps ---"
docker-compose ps

echo -e "\n"
echo "--- URL ---"
echo "--- Opensearch URL ---"
echo https://$(curl -s ifconfig.io):9200
echo "--- Opensearch Dashboard URL ---"
echo http://$(curl -s ifconfig.io):5601

echo -e "\n"
