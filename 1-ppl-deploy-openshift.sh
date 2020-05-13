#!/bin/bash
PROJECT=${1:-quarkus-lab}

#set -x
oc project ${PROJECT}

read -p "native s2i build"

oc new-app quay.io/quarkus/ubi-quarkus-native-s2i:19.3.1-java11~https://github.com/j1cken/quarkus-workshop-labs.git#cloud-native --name='ppl-native' -l "app.openshift.io/runtime=quarkus,app.kubernetes.io/part-of=people,app=people"
read
oc expose service ppl-native
read
oc rollout status -w dc/ppl-native

# Minimal Runtime Build
read -p "minimal runtime build"

oc new-build --name=minimal-ppl-native \
    --docker-image=registry.access.redhat.com/ubi8-minimal \
    --source-image=ppl-native \
    --source-image-path='/home/quarkus/application:.' \
    --dockerfile=$'FROM registry.access.redhat.com/ubi8-minimal:latest\nCOPY application /application\nCMD /application -Xms12m -Xmx36m -Xmn36m\nEXPOSE 8080'
read
oc new-app minimal-ppl-native --allow-missing-imagestream-tags -l "app.openshift.io/runtime=quarkus,app.kubernetes.io/part-of=people,app=people"
read
oc expose svc minimal-ppl-native


read -p "call service"

curl $(oc get route ppl-native -o=go-template --template='{{ .spec.host }}')/hello/greeting/quarkus-on-openshift
read
curl $(oc get route minimal-ppl-native -o=go-template --template='{{ .spec.host }}')/hello/greeting/quarkus-on-openshift

exit 0