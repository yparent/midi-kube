# Épisode 1 — Ton tout premier pod, fait correctement

Bienvenue ! Dans cet épisode, tu déploies ton premier pod Kubernetes — mais **du bon côté
dès le départ** : on voit qu'un pod « par défaut » tourne en root, et on le corrige.

À la fin, tu repars avec un bloc YAML que tu peux coller dans tes propres manifests.

---

## 🎯 Ce que tu vas apprendre
- Ce qu'est un **pod** (la plus petite chose que Kubernetes sait lancer)
- Le mode **déclaratif** : on décrit l'état voulu dans un fichier, Kubernetes s'en occupe
- Lire un fichier **YAML** Kubernetes (les 4 blocs qu'on retrouve partout)
- La 1ʳᵉ bonne pratique sécu : **ne pas faire tourner son app en root**

---

## 🧪 Avant de commencer
1. Monte ton lab (une seule fois) — voir le [README principal](../README.md).
   Le plus simple sans rien installer : [Killercoda](https://killercoda.com/playgrounds).
2. Jamais touché un terminal / git / le YAML ? Lis [PREREQUIS.md](../PREREQUIS.md) (10 min).
3. Clone le repo : `git clone https://github.com/yparent/midi-kube.git`

---

## 📂 Les fichiers de l'épisode
- `manifests/01-base.yaml` — un pod « naïf » : il marche, mais il tourne en root
- `manifests/02-correct.yaml` — le même pod, fait correctement

### Comprendre le YAML en 30 secondes
Un fichier Kubernetes, c'est toujours ces **4 blocs** :

| Bloc | Rôle |
|------|------|
| `apiVersion` | la version du « langage » qu'on parle |
| `kind` | le type d'objet (ici : `Pod`) |
| `metadata` | son identité : nom, namespace |
| `spec` | ce qu'on veut vraiment : l'image, le port, la sécu… |

> ⚠️ En YAML, c'est l'**indentation** qui donne le sens, et on indente avec des **espaces**
> (jamais de tabulations). Un tiret `-` = un élément de liste.

---

## ▶️ Refaire l'épisode, étape par étape

### 1. Déployer le pod « naïf »
```bash
kubectl apply -f ep01-premier-pod/manifests/01-base.yaml
kubectl get pod web -n demo
```
> `apply` = « voilà l'état que je veux ». C'est ça, le mode **déclaratif**.
> (`get`, `exec`, `logs` ne changent rien — ce sont juste des questions.)

### 2. Voir la page répondre
```bash
kubectl port-forward web -n demo 8080:80
# ouvre http://localhost:8080  (Ctrl-C pour arrêter)
```

### 3. Constater le problème
```bash
kubectl exec -it web -n demo -- whoami         # -> root
kubectl exec -it web -n demo -- touch /etc/test # ça passe : on peut écrire partout
```
Ton app tourne en **root** et peut tout faire dans le conteneur. C'est ce qu'on veut éviter.

### 4. Le faire correctement
```bash
kubectl delete pod web -n demo
kubectl apply -f ep01-premier-pod/manifests/02-correct.yaml
kubectl exec -it web -n demo -- whoami          # -> nginx (plus root)
kubectl exec -it web -n demo -- touch /etc/test  # -> Permission denied
```
Deux réglages ont suffi : **ne pas tourner en root**, et **ne pas pouvoir le redevenir**
(plus une image pensée pour ça). Même résultat, mais propre.

---

## ✅ Ton devoir d'ici jeudi prochain
Ouvre [Killercoda](https://killercoda.com/playgrounds), déploie ce pod, et dis en commentaire
du live **si ta page répond**. 💬

## 🎁 Le tip de la semaine
Installe l'extension **YAML de Red Hat** dans VS Code : elle aligne l'indentation, souligne
tes erreurs en rouge et complète les champs Kubernetes. (Voir [TIPS.md](../TIPS.md).)

## ⏭️ La semaine prochaine
Ton pod meurt si le node redémarre. On le rend **immortel** avec le **Deployment**.

---

*Une question ? Pose-la en commentaire du live LinkedIn. Et mets une ⭐ pour retrouver le repo !*
