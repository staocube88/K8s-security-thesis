#!/bin/bash

START=$(date +%s)

kubectl run benign-nginx --image=nginx -n baseline
kubectl run benign-alpine --image=alpine -n baseline

sleep 20

kubectl exec benign-nginx -n baseline -- ls /
kubectl exec benign-nginx -n baseline -- cat /etc/os-release
kubectl exec benign-alpine -n baseline -- ping -c 2 example.com

sleep 10

END=$(date +%s)

ALERTS=$(kubectl logs -n falco -l app=falco --since-time=$(date -u -r $START +"%Y-%m-%dT%H:%M:%SZ") | wc -l)

EVENTS=50

FPR=$(echo "scale=3; $ALERTS / $EVENTS" | bc)

echo "False Positive Rate: $FPR"

