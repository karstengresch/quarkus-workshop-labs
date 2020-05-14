#!/bin/bash

read -p "create new binary build"
oc new-build registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:1.6 --binary --name=people

read -p "build locally first"
./mvnw clean package

read -p "upload binary and start binary build on OpenShift"
oc start-build people --from-file target/*-runner.jar --follow

read -p "deploy postgres database"
echo ""
echo "Namespace (the first one): Select user1-project"
echo "Namespace (the second one): openshift"
echo "Database Service Name: postgres-database"
echo "PostgreSQL Connection Username: sa"
echo "PostgreSQL Connection Password: sa"
echo "PostgreSQL Database Name: person"
echo ""

read -p "create new app"
oc new-app people --allow-missing-imagestream-tags -l "app.openshift.io/runtime=quarkus,app.kubernetes.io/part-of=people,app=people"

read -p "set probes"
dc=people; oc set probe dc/${dc} --readiness --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=20 --get-url=http://:8080/health/ready 
dc=people; oc set probe dc/${dc} --liveness --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=20 --get-url=http://:8080/health/live

#read -p "check rollout status"
oc rollout status dc people

read -p "expose service to outside world"
oc expose svc/people

read -p "test request"
curl -s $(oc get route people -o=go-template --template='{{ .spec.host }}')/person/birth/before/2000 | jq


echo "\n\nopen $(oc get route people -o=go-template --template='{{ .spec.host }}')/datatable.html"