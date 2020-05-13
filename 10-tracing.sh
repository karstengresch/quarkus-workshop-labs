#!/bin/bash

read -p "build locally first, then upload binary and start binary build on OpenShift"
./mvnw clean package
oc start-build people --from-file target/*-runner.jar --follow
oc rollout status -w dc/people

echo "\n\nopen http://$(oc get route people -o=go-template --template='{{ .spec.host }}')/datatable.html"
echo "\n\nopen https://$(oc get route jaeger -o=go-template --template='{{ .spec.host }}')/"

read -p "show RestClient definition"
read -p "show original API"
curl -s https://swapi.dev/api/people/1/ | jq

read -p "trigger traces"
curl -s http://$(oc get route people -o=go-template --template='{{ .spec.host }}')/person/swpeople | jq

echo "\n\nopen https://$(oc get route jaeger -o=go-template --template='{{ .spec.host }}')/"
