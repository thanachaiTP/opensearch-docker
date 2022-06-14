#!/bin/bash
curl -XPUT -u admin:admin -H "Content-type: application/json" 127.0.0.1:9200/_cluster/settings -d '{"persistent":{"compatibility":{"override_main_response_version":true } } }'
