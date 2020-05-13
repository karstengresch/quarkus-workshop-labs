#!/bin/sh

read -p "create Person joe" foo
curl -i -X POST http://localhost:8080/person/joe

read -p "confirm Joe's been created"
curl -s http://localhost:8080/person/name/joe | jq