# Épisode 3 — Donner une adresse stable à ton appli (le Service)

Aux épisodes précédents : un **pod** sécurisé (ép.1), puis un **Deployment** qui le rend
immortel et le multiplie (ép.2). Mais il reste un problème : chaque pod a une **IP qui change**
à chaque renaissance, et il y en a plusieurs. Comment les joindre de façon **stable** ?

Réponse du jour : le **Service**.

---

## Rappel express
Ton Deployment maintient 2 pods en vie. Super. Sauf que tu ne peux pas coder en dur l'IP d'un
pod : elle change dès qu'il meurt et renaît. Il te faut une **porte d'entrée fixe**.

---

## 🎯 Ce que tu vas apprendre
- Pourquoi on ne joint **jamais** un pod par son IP
- Le **Service** : une adresse stable devant tes pods, qui répartit la charge
- Le **selector** : comment le Service retrouve ses pods (le même badge que le Deployment)
- Le **DNS interne** : joindre ton appli par son **nom**, pas par une IP
- Les **types** de Service (ClusterIP / NodePort / LoadBalancer) et lequel choisir
- La bonne pratique : **n'exposer que le strict nécessaire**

---

## 🧪 Avant de commencer (sur Killercoda)
1. Ouvre un playground Kubernetes : https://killercoda.com/playgrounds
2. Clone le repo et crée le namespace :
```bash
git clone https://github.com/yparent/midi-kube.git
cd midi-kube
kubectl create namespace demo
```

---

## 📂 Le fichier de l'épisode
- `manifests/service.yaml` — un Service de type ClusterIP devant tes pods

### Le nouveau vocabulaire (en images)
| Mot | En une phrase | L'image |
|-----|---------------|---------|
| **Service** | Une adresse fixe devant des pods qui changent. | Le standard téléphonique : un seul numéro, il te passe un agent dispo. |
| **ClusterIP** | Adresse interne stable, joignable depuis le cluster. | La ligne interne de l'entreprise. |
| **selector** | Le badge qui dit au Service quels pods servir. | « Je transfère aux agents badge bleu. » |
| **Endpoints** | La liste, tenue à jour seule, des pods vivants derrière le Service. | Le tableau des agents présents au standard. |
| **port / targetPort** | Le port du Service / le port du conteneur. | Le numéro affiché / le poste interne réel. |

---

## ▶️ Refaire l'épisode

### 1. Le problème : l'IP des pods change
```bash
kubectl apply -f ep02-deployment/manifests/deployment.yaml
kubectl get pods -n demo -o wide        # note les IP
kubectl delete pod <nom-d-un-pod> -n demo
kubectl get pods -n demo -o wide        # un nouveau pod, une nouvelle IP
```

### 2. La solution : créer le Service
```bash
kubectl apply -f ep03-service/manifests/service.yaml
kubectl get svc -n demo                 # une ClusterIP stable
kubectl get endpoints web -n demo       # les IP des pods derrière l'adresse stable
```

### 3. Joindre l'appli par son NOM (DNS)
```bash
kubectl run test --image=curlimages/curl -n demo --rm -it --restart=Never -- curl -s web
# "web" = le nom du Service. Résolu par le DNS interne. Port 80 -> 8080. Tu reçois la page nginx.
```

### 4. La magie : le Service suit les pods tout seul
```bash
kubectl delete pod <nom-d-un-pod> -n demo
kubectl get endpoints web -n demo       # l'IP morte disparaît, la nouvelle apparaît — sans rien toucher
```

### 5. (Optionnel) Voir la page dans le navigateur
```bash
kubectl port-forward --address 0.0.0.0 service/web -n demo 30080:80 &
# menu Killercoda (haut droite) -> Traffic/Ports -> 30080 -> Access
```

---

## ✅ Ton devoir
Crée le Service, puis lance `kubectl get endpoints web -n demo -w`. Supprime un pod et dis en
commentaire ce que tu vois se passer dans les endpoints. 💬

## 🎁 Le tip de la semaine
`kubectl get endpoints <service>` — pour voir exactement quels pods se cachent derrière une
adresse stable. Ton meilleur ami quand « le Service ne répond pas ». (Voir [TIPS.md](../TIPS.md).)

## ⏭️ La semaine prochaine
Ton appli tourne, elle est joignable… mais sa config et ses mots de passe sont en dur dans le
YAML. On les sort proprement : **ConfigMap & Secret**.

---

*Une question ? Commentaire du live LinkedIn. Et mets une ⭐ sur le repo !*
