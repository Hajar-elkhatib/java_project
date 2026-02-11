import pickle
import pandas as pd
import numpy as np
import os

def evaluate():
    print("🚀 Chargement des données pour l'évaluation...")
    try:
        movies = pickle.load(open('movies_list.pkl', 'rb'))
        similarity = pickle.load(open('similarity.pkl', 'rb'))
    except FileNotFoundError:
        print("❌ Erreur : Fichiers .pkl introuvables. Lancez train.py d'abord.")
        return

    n_movies = len(movies)
    top_k = 5
    
    genre_consistency = []
    recommended_indices = set()
    avg_similarities = []

    print(f"📊 Évaluation en cours sur {n_movies} films...")

    # On parcours un échantillon de 500 films pour aller vite, ou tout le dataset
    sample_size = min(500, n_movies)
    sample_indices = np.random.choice(n_movies, sample_size, replace=False)

    for i in sample_indices:
        # Récupérer les genres du film d'origine
        original_genres = set(movies.iloc[i]['genre'].split(',')) if isinstance(movies.iloc[i]['genre'], str) else set()
        
        # Récupérer les indices des 5 meilleures recommandations
        distances = sorted(list(enumerate(similarity[i])), reverse=True, key=lambda x: x[1])
        top_recs = distances[1:top_k+1] # On exclut le film lui-même (index 0)
        
        match_count = 0
        current_sims = []
        
        for idx, sim_score in top_recs:
            recommended_indices.add(idx)
            current_sims.append(sim_score)
            
            # Vérifier la cohérence des genres
            rec_genres = set(movies.iloc[idx]['genre'].split(',')) if isinstance(movies.iloc[idx]['genre'], str) else set()
            if original_genres.intersection(rec_genres):
                match_count += 1
        
        genre_consistency.append(match_count / top_k)
        avg_similarities.append(np.mean(current_sims))

    # Calcul des métriques finales
    final_genre_acc = np.mean(genre_consistency) * 100
    final_coverage = (len(recommended_indices) / n_movies) * 100
    final_sim_score = np.mean(avg_similarities)

    print("\n" + "="*30)
    print("      RÉSULTATS DE L'ÉVALUATION")
    print("="*30)
    print(f"✅ Cohérence des genres : {final_genre_acc:.2f}%")
    print(f"   (En moyenne, {final_genre_acc/20:.1f} films sur 5 partagent au moins un genre)")
    print(f"✅ Couverture du catalogue : {final_coverage:.2f}%")
    print(f"   ({len(recommended_indices)} films uniques recommandés sur {n_movies})")
    print(f"✅ Force de similarité moyenne : {final_sim_score:.4f}")
    print("="*30)

if __name__ == "__main__":
    evaluate()
