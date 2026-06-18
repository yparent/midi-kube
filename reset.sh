#!/usr/bin/env bash
# Midi Kube — Reset rapide entre deux essais (service + deployment + pod de démo)
set -euo pipefail
NS="demo"
echo "==> Nettoyage du namespace '${NS}'..."
kubectl delete service web -n "${NS}" --ignore-not-found
kubectl delete deployment web -n "${NS}" --ignore-not-found
kubectl delete pod web -n "${NS}" --force --grace-period=0 --ignore-not-found
echo "OK. ép.1 : kubectl apply -f ep01-premier-pod/manifests/02-correct.yaml"
echo "    ép.2 : kubectl apply -f ep02-deployment/manifests/deployment.yaml"
echo "    ép.3 : kubectl apply -f ep03-service/manifests/service.yaml"
