#!/bin/bash

for dc in ppl-native minimal-ppl-native; do
    oc set probe dc/${dc} --readiness --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=20 --get-url=http://:8080/health/ready 
    oc set probe dc/${dc} --liveness --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=20 --get-url=http://:8080/health/live
done