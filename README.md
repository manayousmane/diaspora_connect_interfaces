# 🟢 DiasporaConnect

> **Transfert d'argent blockchain pour la diaspora béninoise**  
> Envoyez de l'argent au Bénin avec moins de 0,1% de frais — contre 7 à 15% via Western Union ou MoneyGram.

---

## 🏆 Contexte — MIABE HACKATHON 2026

**Projet B-02** | Catégorie D02 — Inclusion financière & DeFi  
**ODD ciblés :** ODD 1 (Fin de la pauvreté) · ODD 8 (Travail décent) · ODD 10 (Inégalités réduites)

---

## 📌 Description de la solution

La diaspora béninoise envoie chaque année **450 à 550 millions USD** à ses familles au Bénin. Mais les services traditionnels comme Western Union ou MoneyGram prélèvent entre **7 et 15%** de chaque transfert.

**DiasporaConnect** est une application mobile qui utilise la blockchain pour éliminer ces intermédiaires. Un smart contract bloque les fonds à l'envoi et les libère instantanément au destinataire — sans qu'aucune banque n'intervienne.

### Résultat concret
| Service | Frais sur 200 EUR | Montant reçu |
|---|---|---|
| Western Union | 18,00 EUR (9%) | 182,00 EUR |
| MoneyGram | 14,00 EUR (7%) | 186,00 EUR |
| **DiasporaConnect** | **0,20 EUR (0,1%)** | **199,80 EUR** |

---

## ✨ Fonctionnalités principales

### Interface Expéditeur (Diaspora)
- ✅ Connexion wallet simulée (MetaMask)
- ✅ Saisie du montant en EUR ou USD
- ✅ Comparatif des frais en temps réel (blockchain vs services traditionnels)
- ✅ Envoi via smart contract avec animation de confirmation
- ✅ Hash de transaction affiché + lien explorateur blockchain
- ✅ Historique des transferts envoyés

### Interface Destinataire (Bénin)
- ✅ Connexion par numéro de téléphone + OTP
- ✅ Tableau de bord avec solde disponible en EUR et FCFA
- ✅ Conversion automatique EUR → FCFA (1 EUR = 655,96 FCFA)
- ✅ Choix du mode de retrait : MTN MoMo / Moov Money / Banque
- ✅ Confirmation de retrait instantanée avec frais zéro
- ✅ Historique des transferts reçus

---

## 🛠️ Technologies utilisées

| Couche | Technologie |
|---|---|
| Application mobile | Flutter (Dart) |
| Blockchain | Polygon (testnet Mumbai) |
| Smart Contract | Solidity |
| Wallet | MetaMask / WalletConnect (simulé) |
| Conversion crypto | Ethers.js |
| Mobile Money | MTN MoMo API (simulé) |
| Taux de change | 1 EUR = 655,96 FCFA (zone CFA) |

---

## 📂 Structure du projet

```
diasporaconnect/
├── lib/
│   └── main.dart          # Code principal de l'application Flutter
├── pubspec.yaml           # Dépendances Flutter
├── android/               # Configuration Android
├── ios/                   # Configuration iOS
└── README.md              # Ce fichier
```

---

## ⚙️ Installation et lancement

### Prérequis
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0 ou supérieure)
- Android Studio ou VS Code avec extension Flutter
- Un émulateur Android/iOS ou un téléphone physique

### Étapes

**1. Cloner le dépôt**
```bash
git clone https://github.com/VOTRE_USERNAME/diasporaconnect.git
cd diasporaconnect
```

**2. Installer les dépendances**
```bash
flutter pub get
```

**3. Lancer l'application**
```bash
flutter run
```

> Pour lancer sur un appareil spécifique :
```bash
flutter run -d android   # Sur Android
flutter run -d ios       # Sur iOS (Mac uniquement)
```

---

## 📱 Guide d'utilisation — Démo

### Parcours Expéditeur
1. Ouvrir l'app → choisir **"Je suis Expéditeur"**
2. Appuyer sur **"Connecter MetaMask"** → wallet connecté automatiquement
3. Saisir **200 EUR** comme montant → observer le comparatif des frais en temps réel
4. Laisser l'adresse destinataire pré-remplie → ajouter une note optionnelle
5. Appuyer sur **"Envoyer via Blockchain"** → suivre les étapes de confirmation

### Parcours Destinataire
1. Revenir à l'accueil → choisir **"Je suis Destinataire"**
2. Numéro pré-rempli : `+229 97 00 00 00` → appuyer sur "Recevoir un code OTP"
3. OTP : **123456** → valider
4. Observer le solde : **199,80 EUR = 131 076 FCFA**
5. Appuyer sur **"Retirer mes fonds"** → sélectionner MTN MoMo → confirmer

---

## ⛓️ Fonctionnement blockchain

```
Expéditeur (France)
       |
       | 1. Appel au smart contract avec le montant
       ↓
Smart Contract (Polygon Testnet)
       |
       | 2. Fonds bloqués en escrow automatiquement
       | 3. Transaction confirmée par le réseau (~8 secondes)
       ↓
Destinataire (Bénin)
       |
       | 4. Fonds libérés et disponibles au retrait
       ↓
MTN MoMo / Moov Money
```

Le smart contract joue le rôle de **banque automatique** : personne ne peut retenir ou détourner les fonds. Tout est vérifiable publiquement sur la blockchain.

---

## 🌍 Impact attendu

Sur les 400 à 500 millions USD de transferts annuels vers le Bénin, une réduction des frais de **10% à 0,1%** représente environ **70 à 100 millions USD restitués chaque année directement aux familles béninoises**.

---


---

## 📄 Licence

Ce projet est développé à des fins de hackathon et de démonstration.  
© 2026 DiasporaConnect — MIABE Hackathon
