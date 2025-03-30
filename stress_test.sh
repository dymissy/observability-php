#!/bin/bash

count=0

while true; do
  # Richiesta 200
  curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/200
  ((count++))

  # Ogni 10 richieste 200, fai una 404
  if (( count % 10 == 0 )); then
    curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/404
  fi

  # Ogni 20 richieste 200, fai una 500
  if (( count % 20 == 0 )); then
    curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/500
  fi

  # (Opzionale) Pausa breve per non stressare troppo il server
  sleep 0.1
done
