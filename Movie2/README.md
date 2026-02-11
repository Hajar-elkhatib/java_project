# 🎬 Movie Recommender System

Ce projet est un système de recommandation de films basé sur le contenu (**Content-Based Filtering**). Il utilise des techniques de Traitement du Langage Naturel (NLP) pour suggérer des films similaires en fonction de leurs genres, titres et résumés.

## � Aperçu du Projet
L'application permet à l'utilisateur de sélectionner un ou plusieurs films qu'il a aimés et génère une liste de 5 recommandations basées sur la similarité textuelle.

## 📂 Structure du Dossier
- `app.py` : L'interface utilisateur interactive créée avec **Streamlit**.
- `train.py` : Le script d'entraînement qui génère la matrice de similarité.
- `evaluate.py` : Script d'évaluation pour mesurer la précision par genre et la couverture du catalogue.
- `dataset.csv` : Le jeu de données contenant les informations des films (ID, Titres, Genres, Synopsis).
- `README.md` : Documentation du projet.
- `.gitignore` : Instructions pour exclure les fichiers volumineux lors de l'envoi sur GitHub.

## 🧠 Le Modèle
Le modèle repose sur :
1. **Vectorisation** : Utilisation de `CountVectorizer` pour transformer le texte en vecteurs numériques (5000 caractéristiques).
2. **Similarité** : Calcul de la **Similarité Cosinus** pour mesurer la distance entre les films.
3. **Optimisation** : Le script `train.py` est capable d'utiliser le **GPU (via PyTorch/CUDA)** pour accélérer les calculs massifs.

## ⚠️ Notes Importantes pour GitHub
Certains fichiers générés lors de l'entraînement sont trop volumineux pour être hébergés directement sur GitHub :
- **`similarity.pkl`** (~800 Mo) : Ce fichier contient la matrice de similarité. Il est automatiquement exclu par le fichier `.gitignore`.
- **`movies_list.pkl`** : Contient les données nettoyées.

**Comment exécuter le projet après un clone :**
Puisque les fichiers `.pkl` ne sont pas sur GitHub, vous devez d'abord entraîner le modèle localement pour les régénérer :
```bash
python train.py
```

## � Installation & Utilisation
1. **Cloner le projet**
2. **Installer les dépendances** :
   ```bash
   pip install pandas numpy scikit-learn streamlit torch requests
   ```
3. **Entraîner le modèle** :
   ```bash
   python train.py
   ```
4. **Lancer l'application** :
   ```bash
   streamlit run app.py
   ```

## 📊 Évaluation
Vous pouvez tester la performance du modèle en lançant :
```bash
python evaluate.py
```
*Derniers résultats obtenus : Cohérence des genres de ~95%.*

---
*Projet réalisé avec Passion pour la Data Science.*
