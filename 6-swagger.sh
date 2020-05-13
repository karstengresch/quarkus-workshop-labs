#!/bin/sh

read -p "OpenAPI YAML format" foo
curl http://localhost:8080/openapi

read -p "OpenAPI JSON format" foo
curl -H "Accept: application/json" http://localhost:8080/openapi

echo "\\n\\nopen http://localhost:8080/swagger-ui"
