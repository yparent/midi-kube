# Épisode 2 — Rendre ton pod immortel (le Deployment)

La semaine dernière, tu as créé ton premier pod, fait correctement. Petit problème : il est
**mortel**. Si la machine redémarre ou si le pod plante, il disparaît et personne ne le relance.

Aujourd'hui, on le rend **immortel** avec un **Deployment** — et on garde toutes les bonnes
pratiques de l'épisode 1.

---

## Rappel express de l'épisode 1
On avait appris à déployer un pod **sans le faire tourner en root**, privilèges retirés et
ressources bornées. Si tu débutes ici, commence par [l'épisode 1](../ep01-premier-pod).

---

## 🎯 Ce que tu vas apprendre
- Pourquoi un pod tout seul est fragile (et pourquoi on n'en déploie jamais « à nu »)
- Le **Deployment** : un manager qui maintient tes pods en vie tout seul
- L'**auto-réparation** (un pod meurt → un nouveau renaît) et le **scaling** en une commande
- Les **labels / selector** : comment le Deployment retrouve ses pods
- Comment **garder la sécu** de l'épisode 1 dans ce nouveau modèle

---

## 🧪 Avant de commencer
1. Ton lab est déjà prêt depuis l'épisode 1 (voir le [README principal](../README.md)).
   Sinon, le plus simple sans rien installer : [Killercoda](https://killercoda.com/playgrounds).
2. Sur Killercoda, pense à recréer le namespace : `kubectl create namespace demo`

---

## 📂 Le fichier de l'épisode
- `manifests/deployment.yaml` — notre pod, enveloppé dans un Deployment

### Le nouveau vocabulaire (en une image)
| Mot | En une phrase | L'image |
|-----|---------------|---------|
| **Deployment** | Un manager qui maintient en permanence le nombre de pods voulu. | Un chef d'équipe qui ne dort jamais. |
| **Replica** | Le nombre de copies identiques du pod. | « Je veux toujours 2 employés au comptoir. » |
| **Label / selector** | L'étiquette qui permet au Deployment de reconnaître ses pods. | Le badge : « je m'occupe de tous les badges bleus ». |

---

## ▶️ Refaire l'épisode, étape par étape

### 1. Voir le problème : le pod est mortel
```bash
kubectl apply -f ep01-premier-pod/manifests/02-correct.yaml
kubectl get pod web -n demo        # Running
kubectl delete pod web -n demo
kubectl get pod web -n demo        # plus rien : mort, définitif
```

### 2. Déployer le Deployment
```bash
kubectl apply -f ep02-deployment/manifests/deployment.yaml
kubectl get pods -n demo           # 2 pods Running
```

### 3. Tester l'immortalité (le moment magique)
Dans un terminal, lance la surveillance en continu :
```bash
kubectl get pods -n demo -w        # -w = watch, suit les changements en direct
```
Dans un autre terminal (ou après Ctrl-C), supprime un pod :
```bash
kubectl delete pod <nom-d-un-pod> -n demo
kubectl get pods -n demo           # un NOUVEAU pod est déjà reparti, tout seul
```

### 4. Scaler en une commande
```bash
kubectl scale deployment web -n demo --replicas=3
kubectl get pods -n demo           # 3 pods
```

---

## ✅ Ton devoir d'ici jeudi prochain
Déploie le Deployment, lance `kubectl get pods -n demo -w`, supprime un pod, et dis en
commentaire **en combien de secondes** il renaît. 💬

## 🎁 Le tip de la semaine
`kubectl explain deployment.spec` — la doc des champs directement dans ton terminal, sans
quitter ta ligne de commande. (Voir [TIPS.md](../TIPS.md).)

## ⏭️ La semaine prochaine
Tes pods ont chacun une adresse… qui change à chaque renaissance. Comment les joindre de façon
stable ? On découvre le **Service**.

---

*Une question ? Pose-la en commentaire du live LinkedIn. Et mets une ⭐ sur le repo !*
