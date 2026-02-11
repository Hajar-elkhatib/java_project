
import pickle
import pandas as pd

movies = pickle.load(open("movies_list.pkl", 'rb'))
print("Genre Type:", type(movies['genre'].iloc[0]))
print("Genre Example:", movies['genre'].iloc[0])
