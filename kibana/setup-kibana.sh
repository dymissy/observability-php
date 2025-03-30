#!/bin/bash

echo "⌛ Waiting for Kibana to be ready..."

# Aspetta che Kibana sia disponibile
until curl -s -o /dev/null http://localhost:5601/api/status; do
  sleep 5
done

echo "🚀 Kibana is up. Creating data view (index pattern)..."

# Crea un data view per l'indice php-logs con campo temporale @timestamp
curl -X POST http://localhost:5601/api/saved_objects/index-pattern/php-logs \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d '{"attributes":{"title":"php-logs","timeFieldName":"@timestamp"}}'

echo "✅ Data view 'php-logs' created successfully."
