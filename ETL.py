import pandas as pd
import awswrangler as awr
import openpyxl
import os
import shutil

#EXTRACT
path_to_query = r"C:\Users\raphael.almeida\Documents\SQL\Seguro de Vida Motorista\base_seguro_de_vida.sql"

with open (path_to_query,'r') as reading:
    query_readed = reading.read()

df = awr.athena.read_sql_query(query_readed,'silver')
df.reset_index(drop=True, inplace=True)

#TRANSFORM


df['e_mail'] = df['unidade'].apply(
    lambda x: f"unidade.{x.replace('UNIDADE ', '').lower()}@transdesk.com.br" 
    if pd.notnull(x) and x != "" and 'UNIDADE ' in x 
    else ''
)



#LOAD
path_to_save = r'C:\Users\raphael.almeida\Documents\SQL\Seguro de Vida Motorista'
file_name = 'Cobertura de Seguros Motoristas.xlsx'
final_path = os.path.join(path_to_save, file_name)
df.to_excel(final_path, engine='openpyxl')







