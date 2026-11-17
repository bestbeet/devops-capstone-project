#!/usr/bin/env bash
# Run from the repo root after the relevant local systems are available.
# This script captures REAL outputs. It does not manufacture passing results.
set -euo pipefail
mkdir -p evidence

echo "Checking local tools..."
for tool in docker kubectl; do command -v "$tool" >/dev/null || { echo "Missing: $tool" >&2; exit 1; }; done

echo "Capturing Docker images (Task 30)"
docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}' | tee evidence/kube-images

echo "Capturing Kubernetes resources (Task 31)"
kubectl get deployments,pods,replicasets,services -o wide | tee evidence/kube-deploy-accounts

echo "Port-forwarding Accounts service is a separate, interactive step:"
echo "  kubectl port-forward svc/accounts 8080:8080"
echo "Then in a second terminal save the actual JSON:"
echo "  curl --fail-with-body -sS http://localhost:8080/ | tee evidence/kube-app-output"

if command -v tkn >/dev/null; then
  echo "Tekton PipelineRuns:"
  tkn pipelinerun list
  echo "To capture COMPLETE Tekton logs (Task 32), run:"
  echo "  tkn pipelinerun logs <actual-run-name> --all > evidence/pipelinerun.txt"
else
  echo "Tekton CLI not installed; install tkn before collecting Task 32."
fi

echo "Remember to take actual GitHub Project screenshots for planning and Done columns."
