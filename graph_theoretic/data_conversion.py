import pandas as pd
df = pd.read_csv('data_form.csv')
df.to_csv('data_form2.csv', index=False)