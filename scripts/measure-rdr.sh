#!/bin/bash

FALCO_NS="falco"
FALCO_POD=$(kubectl get pods -n $FALCO_NS -l app.kubernetes.io/name=falco -o jsonpath='{.items[0].metadata.name}')
TARGET_NS="baseline"
TARGET_POD="insecure-write-root"
ATTACKER_POD="runtime-attacker"

echo "===== Isolated Runtime Detection Rate Experiment ====="
echo "Start Time: $(date)"

# Capture experiment start timestamp (HH:MM:SS)
START_TS=$(date +%H:%M:%S)

echo ""
echo "[1/5] Sensitive File Access"
kubectl exec -n $TARGET_NS $TARGET_POD -- cat /etc/shadow >/dev/null 2>&1
sleep 2

echo "[2/5] Write to Root Filesystem"
kubectl exec -n $TARGET_NS $TARGET_POD -- touch /root/hacked >/dev/null 2>&1
sleep 2

echo "[3/5] Privilege Escalation Attempt"
kubectl exec -n $TARGET_NS $TARGET_POD -- chmod +s /bin/sh >/dev/null 2>&1
sleep 2

echo "[4/5] Network via /dev/tcp"
kubectl exec -n $TARGET_NS $TARGET_POD -- sh -c 'echo test > /dev/tcp/example.com/80' >/dev/null 2>&1
sleep 2

echo "[5/5] Network via curl"
kubectl exec -n $TARGET_NS $ATTACKER_POD -- sh -c "apk add --no-cache curl >/dev/null 2>&1 && curl -s http://example.com >/dev/null 2>&1"
sleep 2

echo ""
echo "Waiting 10 seconds for Falco to process events..."
sleep 10

echo ""
echo "Collecting Falco logs..."

DETECTIONS=$(kubectl logs -n $FALCO_NS $FALCO_POD \
  | awk -v start="$START_TS" '$1 >= start' \
  | grep "$TARGET_POD\|$ATTACKER_POD" \
  | awk '{print $1}' \
  | cut -c1-8 \
  | sort -u \
  | wc -l)

SIMULATED=5

RDR=$(echo "scale=2; $DETECTIONS / $SIMULATED" | bc)

echo ""
echo "===== Experiment Result ====="
echo "Simulated Attacks: $SIMULATED"
echo "Detected Attack Windows: $DETECTIONS"
echo "Runtime Detection Rate (RDR): $RDR"
echo "End Time: $(date)"

