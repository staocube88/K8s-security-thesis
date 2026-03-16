# Kubernetes Layered Security Evaluation Framework

This repository contains the experimental framework used in the thesis:

"Evaluating Layered Kubernetes Security: Admission Control, Supply Chain Verification, and Runtime Threat Detection in DevOps Pipelines"

## Security Layers Evaluated

1. Admission Control Enforcement
2. Supply Chain Image Verification
3. Runtime Threat Detection

## Tools Used

Gatekeeper
Kyverno
Cosign
Falco
Jenkins
Kubernetes

## Experimental Metrics

MBR – Misconfiguration Blocking Rate
RDR – Runtime Detection Rate
SPR – Supply Chain Protection Rate
FPR – False Positive Rate

## Experiment Results

MBR = 0.95  
RDR = 1.0  
SPR = 1.0

## Running the Experiments

chmod +x scripts/*.sh
./scripts/run-k8s-security-evaluation.sh


## CI/CD Integration

Experiments are executed automatically using Jenkins pipelines.
