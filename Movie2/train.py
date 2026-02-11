import pandas as pd
import pickle
from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
import sys
import os

def train_model():
    print("🚀 Loading dataset...", flush=True)
    try:
        movies = pd.read_csv('dataset.csv')
    except FileNotFoundError:
        print("❌ Error: dataset.csv not found!")
        return

    # Preprocessing
    movies = movies[['id', 'title', 'genre', 'overview']]
    movies.dropna(inplace=True)
    movies['tags'] = movies['title'] + " " + movies['overview'] + " " + movies['genre']
    movies.reset_index(drop=True, inplace=True)

    print(f"📊 Prepared {len(movies)} movies.", flush=True)

    print("🧠 Generating features (CountVectorizer)...", flush=True)
    cv = CountVectorizer(max_features=5000, stop_words='english')
    vectors = cv.fit_transform(movies['tags']).toarray()
    
    # Similarity Calculation
    try:
        import torch
        if torch.cuda.is_available():
            device = torch.device('cuda')
            print(f"✅ CUDA is available. Using GPU: {torch.cuda.get_device_name(0)}", flush=True)
            
            # Convert to tensor and move to GPU
            print("⚡ Moving data to GPU...", flush=True)
            tensor = torch.from_numpy(vectors).float().to(device)
            
            # Normalize vectors (L2 norm)
            # Cosine similarity is dot product of normalized vectors
            print("⚡ Normalizing vectors...", flush=True)
            norm = tensor.norm(p=2, dim=1, keepdim=True)
            normalized_tensor = tensor / norm
            
            # Compute similarity matrix
            print("⚡ Computing similarity matrix on GPU...", flush=True)
            similarity_matrix = torch.mm(normalized_tensor, normalized_tensor.t())
            
            # Move back to CPU
            print("⚡ Moving result back to CPU...", flush=True)
            similarity = similarity_matrix.cpu().numpy()
            print("✅ Similarity matrix computation complete.", flush=True)
            
        else:
            print("⚠️ Torch installed but CUDA not available. Falling back to CPU sk-learn...", flush=True)
            from sklearn.metrics.pairwise import cosine_similarity
            similarity = cosine_similarity(vectors)
            
    except ImportError:
        print("⚠️ 'torch' not found. Falling back to CPU sk-learn...", flush=True)
        from sklearn.metrics.pairwise import cosine_similarity
        similarity = cosine_similarity(vectors)

    print("💾 Saving model files...", flush=True)
    pickle.dump(movies, open('movies_list.pkl', 'wb'))
    pickle.dump(similarity, open('similarity.pkl', 'wb'))
    print("✅ Model trained and saved successfully!", flush=True)

if __name__ == '__main__':
    train_model()
