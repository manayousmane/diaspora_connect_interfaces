# 🟢 DiasporaConnect

> **Transfert d'argent blockchain pour la diaspora béninoise**  
> Envoyez de l'argent au Bénin avec moins de 0,1% de frais — contre 7 à 15% via Western Union ou MoneyGram.

---

##  Contexte — MIABE HACKATHON 2026

**Projet B-02** | Catégorie D02 — Inclusion financière & DeFi  
**ODD ciblés :** ODD 1 (Fin de la pauvreté) · ODD 8 (Travail décent) · ODD 10 (Inégalités réduites)

---

##  Description de la solution

La diaspora béninoise envoie chaque année **450 à 550 millions USD** à ses familles au Bénin. Mais les services traditionnels comme Western Union ou MoneyGram prélèvent entre **7 et 15%** de chaque transfert.

**DiasporaConnect** est une application mobile qui utilise la blockchain pour éliminer ces intermédiaires. Un smart contract bloque les fonds à l'envoi et les libère instantanément au destinataire — sans qu'aucune banque n'intervienne.

### Résultat concret
| Service | Frais sur 200 EUR | Montant reçu |
|---|---|---|
| Western Union | 18,00 EUR (9%) | 182,00 EUR |
| MoneyGram | 14,00 EUR (7%) | 186,00 EUR |
| **DiasporaConnect** | **0,20 EUR (0,1%)** | **199,80 EUR** |

---

##  Fonctionnalités principales

### Interface Expéditeur (Diaspora)
-  Connexion wallet simulée (MetaMask)
-  Saisie du montant en EUR ou USD
-  Comparatif des frais en temps réel (blockchain vs services traditionnels)
-  Envoi via smart contract avec animation de confirmation
-  Hash de transaction affiché + lien explorateur blockchain
-  Historique des transferts envoyés

### Interface Destinataire (Bénin)
-  Connexion par numéro de téléphone + OTP
-  Tableau de bord avec solde disponible en EUR et FCFA
-  Conversion automatique EUR → FCFA (1 EUR = 655,96 FCFA)
-  Choix du mode de retrait : MTN MoMo / Moov Money / Banque
-  Confirmation de retrait instantanée avec frais zéro
-  Historique des transferts reçus

---

##  Technologies utilisées

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

##  Structure du projet

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

##  Impact attendu

Sur les 400 à 500 millions USD de transferts annuels vers le Bénin, une réduction des frais de **10% à 0,1%** représente environ **70 à 100 millions USD restitués chaque année directement aux familles béninoises**.

---

