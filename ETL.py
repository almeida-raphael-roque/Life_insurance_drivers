import pandas as pd
import awswrangler as awr
import openpyxl
import os
import shutil
import unicodedata
import win32com.client as win32



#-----------------EXTRACT
path_to_query = r"C:\Users\raphael.almeida\Documents\Projetos\Seguro de Vida Motorista\base_seguro_de_vida.sql"

with open (path_to_query,'r') as reading:
    query_readed = reading.read()

df = awr.athena.read_sql_query(query_readed,'silver')




#-----------------TRANSFORM
#adding empty e-mails with the e-mail common pattern
row = df['e_mail'].isnull() & df['unidade'].str.contains('UNIDADE ')
df.loc[row, 'e_mail'] = 'unidade.' + df.loc[row, 'unidade'].str.replace('UNIDADE ', '').str.lower() + '@transdesk.com.br'

#removing empty spaces
df['e_mail'] = df['e_mail'].str.replace(' ','')

#removing diacritics with unicodedata
def remove_diacritics (texto):
    if isinstance(texto,str):
        return ''.join(c for c in unicodedata.normalize('NFKD',texto) if not unicodedata.combining(c))
    return texto

df['e_mail'] = df['e_mail'].apply(remove_diacritics)

df = df.reset_index(drop=True)

df_unidemail = df.groupby(['unidade', 'e_mail']).agg(
    placas=('placa', 'count'),
    motoristas=('motorista', 'count')
).reset_index()


df_unidemail_filtered = df_unidemail[df_unidemail['placas']>df_unidemail['motoristas']]



#-----------------LOAD
#Function to send e-mails

def enviar_email(p_email, p_unidade, p_placas, p_motoristas):    
    outlook = win32.Dispatch('outlook.application')  #integrating python with outlook 

    #creating e-mail variable to use
    email = outlook.CreateItem(0)

    #configuring the e-mail
    email.To = p_email
    email.Subject = "[CADASTRAMENTO DE MOTORISTAS] - Análise de Dados"
    email.HTMLBody = f"""
    <p>Prezado(a),<p/>

    <p>A unidade {p_unidade}, correspondente ao e-mail {p_email}, possui pendências de cadastramento de motoristas por placa:

    <p>Número de placas cadastradas: {p_placas}
    Número de motoristas cadastrados: {p_motoristas}<p/>

    <p>Favor, cadastrar as placas remanescentes para cômputo na base de dados da empresa, obrigado!<p/>

    <p>Atenciosamente,<p/>

    <p>Equipe Análise de Dados - Grupo Unus<p/>

    <p>(<i>Este é um e-mail automático, por favor não responda<i/>)<p/>
 
    """

    email.Send()

    



df_numeros = df_unidemail_filtered.groupby(['unidade']).agg(
    qtd_placas=('placas', 'sum'),
    qtd_motoristas=('motoristas', 'sum')
).reset_index()

for idx, row in df_unidemail_filtered.iterrows():
    iEmail = row['e_mail']
    iUnidade = row['unidade']

    unidade_info = df_numeros.loc[df_numeros['unidade'] == iUnidade].iloc[0]

    iQtdPlacas = unidade_info['qtd_placas']
    iQtdMotoristas = unidade_info['qtd_motoristas']

    if __name__=="__main__":
        enviar_email(iEmail, iUnidade, iQtdPlacas, iQtdMotoristas)

    
    print(f"e_mail:{iEmail}/unidade:{iUnidade}/placas:{iQtdPlacas}/motoristas:{iQtdMotoristas}")

    

path_to_save = r'C:\Users\raphael.almeida\Documents\Projetos\Seguro de Vida Motorista'
file_name = 'Cobertura de Seguros Motoristas.xlsx'
final_path = os.path.join(path_to_save, file_name)
df.to_excel(final_path, engine='openpyxl', index = False)