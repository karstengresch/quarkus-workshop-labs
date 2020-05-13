#!/bin/bash

read -p "create prometheus configmap"
oc create configmap prom --from-file=prometheus.yml=src/main/kubernetes/prometheus.yml

read -p "mount configmap into container"
oc set volume deployment/prometheus --add -t configmap --configmap-name=prom -m /etc/prometheus/prometheus.yml --sub-path=prometheus.yml
oc rollout status -w deployment/prometheus

read -p "execute 9-1-monitoring.sh to show metrics locally, then re-deploy to OpenShift"

read -p "build locally first"
./mvnw clean package

read -p "upload binary and start binary build on OpenShift"
oc start-build people --from-file target/*-runner.jar --follow
oc rollout status -w dc/people

echo "\n\nopen http://$(oc get route people -o=go-template --template='{{ .spec.host }}')/names.html"
echo "\n\nopen http://$(oc get route prometheus -o=go-template --template='{{ .spec.host }}')/"

read -p "create grafana deployment before continuing"
read -p "login with admin/admin"
echo "\n\nopen http://$(oc get route grafana -o=go-template --template='{{ .spec.host }}')/"
