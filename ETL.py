import pandas as pd
import awswrangler as awr
import openpyxl
import os
import shutil
import unicodedata

#EXTRACT
path_to_query = r"C:\Users\raphael.almeida\Documents\SQL\Seguro de Vida Motorista\base_seguro_de_vida.sql"

with open (path_to_query,'r') as reading:
    query_readed = reading.read()

df = awr.athena.read_sql_query(query_readed,'silver')


#TRANSFORM

#adding a column e-mail with the unity's name in it's domain
df['e_mail'] = df['unidade'].apply(
    lambda x: f"unidade.{x.replace('UNIDADE ', '').lower()}@transdesk.com.br" 
    if pd.notnull(x) 
        and x != "" 
        and 'UNIDADE ' in x
    else ''
)

#removing empty spaces
df['e_mail'] = df['e_mail'].str.replace(' ','')

#removing diacritics with unicodedata

def remove_diacritics (texto):
    if isinstance(texto,str):
        return ''.join(c for c in unicodedata.normalize('NFKD',texto) if not unicodedata.combining(c))
    return texto

df['e_mail'] = df['e_mail'].apply(remove_diacritics)

df = df.reset_index(drop=True)


#LOAD

path_to_save = r'C:\Users\raphael.almeida\Documents\SQL\Seguro de Vida Motorista'
file_name = 'Cobertura de Seguros Motoristas.xlsx'
final_path = os.path.join(path_to_save, file_name)
os.remove(final_path)
df.to_excel(final_path, engine='openpyxl', index = False)






