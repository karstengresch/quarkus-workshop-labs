#!/bin/bash

read -p "build locally first"
./mvnw clean package

read -p "upload binary and start binary build on OpenShift"
oc start-build people --from-file target/*-runner.jar --follow

echo "\n\nopen http://$(oc get route people -o=go-template --template='{{ .spec.host }}'/names.html)"
