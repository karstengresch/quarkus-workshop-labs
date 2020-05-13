#!/bin/bash

read -p "build locally first, then upload binary and start binary build on OpenShift"
./mvnw clean package
oc start-build people --from-file target/*-runner.jar --follow
oc rollout status -w dc/people

read -p "use insomnia ..."