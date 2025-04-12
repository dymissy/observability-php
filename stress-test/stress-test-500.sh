#!/bin/bash

count=0

while true; do
  curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/500

  sleep 0.01
done
