#!/bin/bash

echo "===================================="
echo "Kubernetes Security Evaluation Start"
echo "===================================="

DATE=$(date)

echo ""
echo "Experiment Timestamp: $DATE"
echo ""

# Create results folder
mkdir -p results

############################################
echo "Running MBR Experiment (Admission Control)"
############################################

./measure-mbr.sh | tee results/mbr-result.txt

sleep 5

############################################
echo "Running RDR Experiment (Runtime Detection)"
############################################

./measure-rdr.sh | tee results/rdr-result.txt

sleep 5

############################################
echo "Running SPR Experiment (Supply Chain)"
############################################

./measure-spr.sh | tee results/spr-result.txt

sleep 5

############################################
echo "Running FPR Experiment (False Positives)"
############################################

./measure-fpr.sh | tee results/fpr-result.txt

sleep 5

############################################
echo "Generating Final Metrics Report"
############################################

./generate-security-report.sh

echo ""
echo "===================================="
echo "Security Evaluation Completed"
echo "===================================="

