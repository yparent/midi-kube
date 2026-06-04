#!/usr/bin/env bash
# Midi Kube — Préparation du terrain de jeu (kind). À lancer une seule fois, AVANT le live.
set -euo pipefail

CLUSTER="midikube"
NS="demo"
IMG_BASE="nginx:stable"
IMG_UNPRIV="nginxinc/nginx-unprivileged:stable"

echo "==> Vérification des prérequis..."
command -v docker  >/dev/null || { echo "Docker introuvable. Installe Docker Desktop / Docker Engine."; exit 1; }
command -v kind    >/dev/null || { echo "kind introuvable. brew install kind  (ou winget install Kubernetes.kind)"; exit 1; }
command -v kubectl >/dev/null || { echo "kubectl introuvable."; exit 1; }

echo "==> Création du cluster '${CLUSTER}' (si absent)..."
if ! kind get clusters | grep -qx "${CLUSTER}"; then
  kind create cluster --name "${CLUSTER}"
else
  echo "    Cluster deja present, on le garde."
fi

echo "==> Pre-telechargement des images (zero pull pendant le live)..."
docker pull "${IMG_BASE}"
docker pull "${IMG_UNPRIV}"

echo "==> Chargement des images dans kind..."
kind load docker-image "${IMG_BASE}" "${IMG_UNPRIV}" --name "${CLUSTER}"

echo "==> Namespace '${NS}'..."
kubectl create namespace "${NS}" --dry-run=client -o yaml | kubectl apply -f -

echo "==> Contexte kubectl..."
kubectl config use-context "kind-${CLUSTER}"

echo ""
echo "PRET."
echo "  Verifie     : kubectl get nodes"
echo "  Lance demo  : kubectl apply -f ep01-premier-pod/manifests/01-base.yaml"
echo "  Split pane  : kubectl get pods -n ${NS} -w"
