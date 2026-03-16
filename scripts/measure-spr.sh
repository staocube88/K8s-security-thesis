#!/bin/bash

TOTAL=10
BLOCKED=0

for i in {1..10}
do
  OUTPUT=$(kubectl run unsigned-$i \
  --image=nginx \
  -n hardened \
  --restart=Never 2>&1)

  if echo "$OUTPUT" | grep -qi "denied"; then
    BLOCKED=$((BLOCKED+1))
  fi
done

SPR=$(echo "scale=2; $BLOCKED / $TOTAL" | bc)

echo "--------------------------------"
echo "Supply Chain Protection Rate"
echo "Blocked: $BLOCKED"
echo "Total: $TOTAL"
echo "SPR = $SPR"
echo "--------------------------------"

