import streamlit as st
import pickle
import requests
import os
import numpy as np

# Function to fetch movie details from TMDB API
def fetch_details(movie_id):
    url = f"https://api.themoviedb.org/3/movie/{movie_id}?api_key=c7ec19ffdd3279641fb606d19ceb9bb1&language=en-US"
    response = requests.get(url)
    data = response.json()
    details = {
        "poster": f"https://image.tmdb.org/t/p/w500/{data.get('poster_path', '')}",
        "title": data.get('title', 'N/A'),
        "overview": data.get('overview', 'No overview available.'),
        "release_date": data.get('release_date', 'N/A'),
        "rating": data.get('vote_average', 'N/A'),
        "genres": ", ".join([genre['name'] for genre in data.get('genres', [])])
    }
    return details

# Function to reconstruct similarity.pkl from smaller parts
def reconstruct_similarity():
    PARTS_DIR = "similarity_parts"
    
    if not os.path.exists(PARTS_DIR):
        raise FileNotFoundError("❌ Error: similarity_parts directory not found!")

    part_files = sorted([f for f in os.listdir(PARTS_DIR) if f.startswith("similarity_part_")])
    
    if not part_files:
        raise FileNotFoundError("❌ Error: No similarity matrix parts found!")

    data = bytearray()  # Use bytearray to properly concatenate binary data
    for part in part_files:
        part_path = os.path.join(PARTS_DIR, part)
        with open(part_path, "rb") as f:
            data.extend(f.read())

    # Deserialize the reconstructed similarity matrix
    try:
        similarity_matrix = pickle.loads(data)
        return similarity_matrix
    except pickle.UnpicklingError:
        raise ValueError("❌ Error: Failed to reconstruct similarity matrix. Ensure all parts are present and not corrupted.")

# Load movie data
try:
    movies = pickle.load(open("movies_list.pkl", 'rb'))
    movies_list = movies['title'].values
except FileNotFoundError:
    st.error("❌ Error: 'movies_list.pkl' not found! Please run train.py first.")
    movies_list = []

# Load Similarity Matrix
similarity = None
if os.path.exists("similarity.pkl"):
    print("Loading similarity.pkl directly...")
    similarity = pickle.load(open("similarity.pkl", 'rb'))
elif os.path.exists("similarity_parts"):
    st.info("🔄 Reconstructing similarity matrix from parts...")
    try:
        similarity = reconstruct_similarity() 
    except Exception as e:
        st.error(f"❌ Error reconstructing similarity matrix: {e}")
else:
    st.error("❌ Error: Similarity matrix not found! Please run train.py first.")

# Streamlit UI
st.title("🎬 Movie Recommender System")

# Select movies from multiselect
selected_movies = st.multiselect("🔍 Select movies you like:", movies_list)

# Display selected movies (optional, just listing them for confirmation if needed)
# if selected_movies:
#    st.write(f"selected: {', '.join(selected_movies)}")

# Recommendation function
def recommend(movie_list):
    if similarity is None:
        st.error("❌ Similarity matrix not loaded. Cannot generate recommendations.")
        return []

    if not movie_list:
        return []

    # Get indices of the selected movies
    movie_indices = [movies[movies['title'] == m].index[0] for m in movie_list]

    # Calculate the average similarity vector
    combined_similarity = np.zeros(len(similarity))
    for idx in movie_indices:
        combined_similarity += similarity[idx]
    
    # Average the scores
    combined_similarity /= len(movie_list)

    # Sort based on similarity score
    distance = sorted(list(enumerate(combined_similarity)), reverse=True, key=lambda vector: vector[1])
    
    # Get top 5 recommendations, excluding the selected movies
    recommend_movie_ids = []
    selected_indices = set(movie_indices)
    
    for i in distance:
        if i[0] not in selected_indices:
            recommend_movie_ids.append(movies.iloc[i[0]].id)
            if len(recommend_movie_ids) >= 5:
                break
                
    return recommend_movie_ids

# Show recommended movies
if st.button("🎥 Show Recommendations"):
    if similarity is None:
        st.error("❌ Cannot generate recommendations because similarity matrix is missing.")
    elif not selected_movies:
        st.warning("⚠️ Please select at least one movie first.")
    else:
        st.subheader("🔥 Recommended Movies:")
        movie_ids = recommend(selected_movies)
        
        if movie_ids:
            cols = st.columns(5)
            for idx, movie_id in enumerate(movie_ids):
                details = fetch_details(movie_id)
                # Ensure we don't go out of bounds if fewer than 5 recommendations
                if idx < len(cols):
                    with cols[idx]:
                        st.image(details['poster'], use_container_width=True, caption=details['title'])
                        st.write(f"**📅 Release Date:** {details['release_date']}")
                        st.write(f"**⭐ Rating:** {details['rating']}")
                        st.write(f"**🎭 Genres:** {details['genres']}")
                        st.write(f"**📖 Overview:** {details['overview']}\n")
