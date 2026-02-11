
import pickle
import pandas as pd

try:
    movies = pickle.load(open("movies_list.pkl", 'rb'))
    print("Columns:", movies.columns)
    print("First 2 rows:", movies.head(2))
except Exception as e:
    print(e)
