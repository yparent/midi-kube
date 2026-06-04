# ☸️ Midi Kube

> **30 minutes. Le jeudi. À 12h30.**
> La pause déj qui te fait monter en compétence sur Kubernetes — un concept par semaine,
> **avec sa bonne pratique intégrée dès le départ.**

La plupart des gens apprennent Kubernetes de travers : tout en mode « ça marche », et ça pète
le jour de la prod. Ici, on apprend **bien dès le premier pod**, et on monte ensemble, semaine
après semaine. Pas de slides corporate, pas de « ça dépend du contexte ». Du concret, applicable
cet après-midi.

Ce repo = tous les fichiers pour **refaire chaque épisode toi-même**.

---

## 🧪 Le lab (à faire une seule fois)

Tu peux suivre **quelle que soit ta machine**. Deux chemins, mêmes commandes `kubectl` :

### Option A — Killercoda (recommandé pour débuter : rien à installer)
Navigateur, gratuit, un cluster prêt en 30 s. Idéal Mac / Windows / Linux / Chromebook.
👉 https://killercoda.com/playgrounds

### Option B — kind (un vrai cluster local)
```bash
# macOS / Linux
brew install kind            # ou : go install sigs.k8s.io/kind@latest
# Windows
winget install Kubernetes.kind

# prérequis : Docker Desktop (Mac/Win) ou Docker Engine (Linux)
```
Puis, depuis la racine de ce repo :
```bash
chmod +x setup.sh reset.sh
./setup.sh                   # crée le cluster, pré-charge les images, crée le namespace 'demo'
kubectl get nodes            # doit afficher un node Ready
```

> 🆕 Jamais touché un terminal / git / le YAML ? Lis **[PREREQUIS.md](PREREQUIS.md)** (10 min, et tu suis tout).
> 🎁 Un tip d'outillage par épisode dans **[TIPS.md](TIPS.md)**.

---

## 📺 Les épisodes

| # | Sujet | Concept de base | Bonne pratique intégrée | Fichiers |
|---|-------|-----------------|-------------------------|----------|
| 01 | **Ton premier pod, fait correctement** | Pod, déclaratif, YAML | Ne pas tourner en root | [ep01-premier-pod](ep01-premier-pod) |
| 02 | Rendre le pod immortel | Deployment | *(à venir)* | — |
| 03 | Lui donner une adresse stable | Service | *(à venir)* | — |
| 04 | Sortir la config du code | ConfigMap / Secret | *(à venir)* | — |
| 05 | Savoir s'il est en vie | Probes | *(à venir)* | — |
| … | … vers la sécu (NetworkPolicy, RBAC, seccomp) → CKS | | | |

> Les fichiers solution de chaque épisode sont publiés **après** le live du jeudi.
> Mets une ⭐ pour retrouver le repo, et reviens chaque semaine.

---

## 🚀 Comment suivre un épisode
1. `git clone https://github.com/yparent/midi-kube.git`
2. Monte ton lab (ci-dessus, une seule fois).
3. Va dans le dossier de l'épisode, lis son `README`, refais la démo.

---

*Aux fourneaux : Yohan Parent — Cloud Architect & formateur Kubernetes.*
