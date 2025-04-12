#!/bin/bash

count=0

while true; do
  curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/200
  ((count++))

  # A 404 request every 10 successful requests
  if (( count % 10 == 0 )); then
    curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/404
  fi

  # A 500 request every 20 successful requests
  if (( count % 20 == 0 )); then
    curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/500
  fi

  sleep 0.1
done
