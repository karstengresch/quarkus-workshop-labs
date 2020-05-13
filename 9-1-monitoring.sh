#!/bin/bash

read -p "trigger a greeting"
curl http://localhost:8080/hello/greeting/quarkus

read -p "print metrics"
curl http://localhost:8080/metrics/application