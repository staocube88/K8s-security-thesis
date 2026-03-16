#!/bin/bash

echo ""
echo "================================"
echo "Kubernetes Security Evaluation Report"
echo "================================"

MBR=$(grep -i "MBR" results/mbr-result.txt | awk '{print $2}')
RDR=$(grep -i "Runtime Detection Rate" results/rdr-result.txt | awk '{print $5}')
SPR=$(grep -i "SPR" results/spr-result.txt | awk '{print $3}')
FPR=$(grep -i "False Positive Rate" results/fpr-result.txt | awk '{print $4}')

echo ""
echo "Final Metrics"
echo "-------------"
echo "MBR = $MBR"
echo "RDR = $RDR"
echo "SPR = $SPR"
echo "FPR = $FPR"
echo ""

echo "--------------------------------"
echo "Interpretation"
echo "--------------------------------"

echo "Admission Control Strength : $MBR"
echo "Runtime Detection Capability : $RDR"
echo "Supply Chain Enforcement : $SPR"
echo "Detection Accuracy : $FPR"

echo ""

echo "Report generated at: $(date)"

