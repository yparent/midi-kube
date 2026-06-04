#!/usr/bin/env bash
# Midi Kube — Reset rapide entre deux essais
set -euo pipefail
NS="demo"
echo "==> Suppression du pod 'web' dans le namespace '${NS}'..."
kubectl delete pod web -n "${NS}" --force --grace-period=0 --ignore-not-found
echo "OK. Relance : kubectl apply -f ep01-premier-pod/manifests/01-base.yaml"
