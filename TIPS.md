# 🎁 Les tips Midi Kube

Un tip d'outillage par épisode. Ils s'accumulent ici — reviens chaque jeudi.

## Ép. 1 — Écrire du YAML sans pleurer
- **Extension VS Code « YAML » (Red Hat)** — `redhat.vscode-yaml`
  Indentation auto, erreurs soulignées en rouge **avant** que Kubernetes râle, et
  autocomplétion des champs Kubernetes (tu tapes `kind:`, elle te propose). Le filet
  de sécurité du débutant.
- **Extension VS Code « Kubernetes » (officielle)** — `ms-kubernetes-tools.vscode-kubernetes-tools`
  Visualise tes clusters, namespaces et pods directement dans VS Code, sans tout taper.
- **Alias `k=kubectl`** — le tip qui fait gagner 1000 frappes par semaine :
  ```bash
  echo 'alias k=kubectl' >> ~/.bashrc   # ou ~/.zshrc
  source ~/.bashrc
  k get pods                            # au lieu de kubectl get pods
  ```

<!-- Ép. 2 — à venir -->
