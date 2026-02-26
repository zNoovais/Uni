import kagglehub
import pandas as pd
import os

path = kagglehub.dataset_download("omarxadel/fitness-exercises-dataset")

print("Path to dataset files:", path)

file_path = os.path.join(path, "exercises.csv")
df = pd.read_csv(file_path)

print(df)
