select distinct

'Segtruck' as "cooperativa",
cata.FANTASIA as "unidade",
cat.NOME as "cliente",
ir.ID as "matricula",
irs.ID as "conjunto",
irsc.ID as "coverage",
b.DESCRIPTION as "beneficio", 
CASE 
WHEN irsc.id_driver IS NOT NULL THEN ip.name
ELSE NULL
END AS "Motorista", --^principais

coalesce(iv.id,it.id) as "id_placa",
coalesce(iv.BOARD,it.BOARD, itt.BOARD) as "placa",
coalesce(iv.chassi, it.chassi) as "chassi",
coalesce(iv.renavam, it.renavam) as "renavam", --^veículos 

cast(irs.DATE_ACTIVATION as date) as "ativacao",
cast(coalesce(irs.DATE_INITAL_EFFECT, date_add('day', -364, irs.DATE_FINAL_EFFECT)) as date) as "inicio_vig", 
cast(irs.DATE_FINAL_EFFECT as date) as "fim_vig", --^datas

iss.DESCRIPTION as "status",
issc.DESCRIPTION as "status_coverage",--^status

b.ID as "benefits_id",
c.DESCRIPTION as "categoria",
tc.DESCRIPTION as "tipo_categoria",
plb.DESCRIPTION as "faixa_valor",
plb.active as "tabela_ativa",--detalhes de benefícios

case 
    when b.id in (4, 19, 21) then 'Reboque/Semirreboque'
    else tv.DESCRICAO 
end as "tipo_veiculo",
case 
    when irs.ID_RENOVATED_SET > 0 then 'Renovação' 
    when irs.ID_REPLACED_SET > 0 then 'Substituição'
    else 'Novo' 
end as "tipo",--^extras
ctt.e_mail
    
from silver.INSURANCE_REG_SET irs
left join silver.INSURANCE_REGISTRATION ir on ir.ID = irs.PARENT
left join silver.INSURANCE_REG_SET_COVERAGE irsc on irsc.PARENT = irs.ID  
left join silver.INSURANCE_REG_SET_COV_TRAILER irsct on irsct.PARENT = irsc.ID --tabelas principais

left join silver.CLIENTE cli on cli.CODIGO = ir.CUSTOMER_ID
left join silver.CATALOGO cat on cat.CNPJ_CPF = cli.CNPJ_CPF--clientes

left join silver.REPRESENTANTE r on r.CODIGO = irs.ID_UNITY
left join silver.CATALOGO cata on cata.CNPJ_CPF = r.CNPJ_CPF
left join silver.contato ctt ON ctt.cnpj_cpf = cata.cnpj_cpf--unidades

left join silver.INSURANCE_STATUS iss on iss.ID = irs.ID_STATUS--status
left join silver.INSURANCE_STATUS issc on issc.ID = irsc.ID_STATUS

left join silver.PRICE_LIST_BENEFITS plb on plb.ID = irsc.ID_PRICE_LIST
left join silver.TYPE_CATEGORY tc on tc.ID = plb.ID_TYPE_CATEGORY
left join silver.CATEGORY c on c.ID = tc.ID_CATEGORY
left join silver.BENEFITS b on b.ID = c.ID_BENEFITS --benefícios

left join silver.INSURANCE_VEHICLE iv on iv.ID = irsc.ID_VEHICLE
left join silver.TIPO_VEICULO tv on tv.CODIGO = iv.CODE_TYPE_VEHICLE
left join silver.insurance_trailer it ON it.id = irsc.id_trailer
left join silver.insurance_trailer itt ON itt.id = irsct.id_trailer --placas

left join  silver.insurance_people ip ON ip.id = irsc.id_people --motoristas

where iss.description = 'ATIVO'
and issc.description = 'ATIVO'


----------------------------------------------------------------------
UNION ALL
----------------------------------------------------------------------


select distinct

'Stcoop' as "cooperativa",
cata.FANTASIA as "unidade",
cat.NOME as "cliente",
ir.ID as "matricula",
irs.ID as "conjunto",
irsc.ID as "coverage",
b.DESCRIPTION as "beneficio", 
CASE 
WHEN irsc.id_driver IS NOT NULL THEN ip.name
ELSE NULL
END AS "Motorista", --^principais

coalesce(iv.id,it.id) as "id_placa",
coalesce(iv.BOARD,it.BOARD, itt.BOARD) as "placa",
coalesce(iv.chassi, it.chassi) as "chassi",
coalesce(iv.renavam, it.renavam) as "renavam", --^veículos 

cast(irs.DATE_ACTIVATION as date) as "ativacao",
cast(coalesce(irs.DATE_INITAL_EFFECT, date_add('day', -364, irs.DATE_FINAL_EFFECT)) as date) as "inicio_vig", 
cast(irs.DATE_FINAL_EFFECT as date) as "fim_vig", --^datas

iss.DESCRIPTION as "status",
issc.DESCRIPTION as "status_coverage",--^status

b.ID as "benefits_id",
c.DESCRIPTION as "categoria",
tc.DESCRIPTION as "tipo_categoria",
plb.DESCRIPTION as "faixa_valor",
plb.active as "tabela_ativa",--detalhes de benefícios

case 
    when b.id in (26, 35, 37) then 'Reboque/Semirreboque'
    else tv.DESCRICAO 
end as "tipo_veiculo",
case 
    when irs.ID_RENOVATED_SET > 0 then 'Renovação' 
    when irs.ID_REPLACED_SET > 0 then 'Substituição'
    else 'Novo' 
end as "tipo",--^extras
ctt.e_mail
    
from stcoop.INSURANCE_REG_SET irs
left join stcoop.INSURANCE_REGISTRATION ir on ir.ID = irs.PARENT
left join stcoop.INSURANCE_REG_SET_COVERAGE irsc on irsc.PARENT = irs.ID  
left join stcoop.INSURANCE_REG_SET_COV_TRAILER irsct on irsct.PARENT = irsc.ID --tabelas principais

left join stcoop.CLIENTE cli on cli.CODIGO = ir.CUSTOMER_ID
left join stcoop.CATALOGO cat on cat.CNPJ_CPF = cli.CNPJ_CPF--clientes

left join stcoop.REPRESENTANTE r on r.CODIGO = irs.ID_UNITY
left join stcoop.CATALOGO cata on cata.CNPJ_CPF = r.CNPJ_CPF
left join stcoop.contato ctt ON ctt.cnpj_cpf = cata.cnpj_cpf--unidades

left join stcoop.INSURANCE_STATUS iss on iss.ID = irs.ID_STATUS--status
left join stcoop.INSURANCE_STATUS issc on issc.ID = irsc.ID_STATUS

left join stcoop.PRICE_LIST_BENEFITS plb on plb.ID = irsc.ID_PRICE_LIST
left join stcoop.TYPE_CATEGORY tc on tc.ID = plb.ID_TYPE_CATEGORY
left join stcoop.CATEGORY c on c.ID = tc.ID_CATEGORY
left join stcoop.BENEFITS b on b.ID = c.ID_BENEFITS --benefícios

left join stcoop.INSURANCE_VEHICLE iv on iv.ID = irsc.ID_VEHICLE
left join stcoop.TIPO_VEICULO tv on tv.CODIGO = iv.CODE_TYPE_VEHICLE
left join stcoop.insurance_trailer it ON it.id = irsc.id_trailer
left join stcoop.insurance_trailer itt ON itt.id = irsct.id_trailer --placas

left join  stcoop.insurance_people ip ON ip.id = irsc.id_people --motoristas

where iss.description = 'ATIVO'
and issc.description = 'ATIVO'


----------------------------------------------------------------------
UNION ALL
----------------------------------------------------------------------

select distinct

'Viavante' as "cooperativa",
cata.FANTASIA as "unidade",
cat.NOME as "cliente",
ir.ID as "matricula",
irs.ID as "conjunto",
irsc.ID as "coverage",
b.DESCRIPTION as "beneficio", 
CASE 
WHEN irsc.id_driver IS NOT NULL THEN ip.name
ELSE NULL
END AS "Motorista", --^principais

coalesce(iv.id,it.id) as "id_placa",
coalesce(iv.BOARD,it.BOARD, itt.BOARD) as "placa",
coalesce(iv.chassi, it.chassi) as "chassi",
coalesce(iv.renavam, it.renavam) as "renavam", --^veículos 

cast(irs.DATE_ACTIVATION as date) as "ativacao",
cast(coalesce(irs.DATE_INITAL_EFFECT, date_add('day', -364, irs.DATE_FINAL_EFFECT)) as date) as "inicio_vig", 
cast(irs.DATE_FINAL_EFFECT as date) as "fim_vig", --^datas

iss.DESCRIPTION as "status",
issc.DESCRIPTION as "status_coverage",--^status

b.ID as "benefits_id",
c.DESCRIPTION as "categoria",
tc.DESCRIPTION as "tipo_categoria",
plb.DESCRIPTION as "faixa_valor",
plb.active as "tabela_ativa",--detalhes de benefícios

case 
    when b.id in (4, 19, 21) then 'Reboque/Semirreboque'
    else tv.DESCRICAO 
end as "tipo_veiculo",
case 
    when irs.ID_RENOVATED_SET > 0 then 'Renovação' 
    when irs.ID_REPLACED_SET > 0 then 'Substituição'
    else 'Novo' 
end as "tipo",--^extras
ctt.e_mail
    
from viavante.INSURANCE_REG_SET irs
left join viavante.INSURANCE_REGISTRATION ir on ir.ID = irs.PARENT
left join viavante.INSURANCE_REG_SET_COVERAGE irsc on irsc.PARENT = irs.ID  
left join viavante.INSURANCE_REG_SET_COV_TRAILER irsct on irsct.PARENT = irsc.ID --tabelas principais

left join viavante.CLIENTE cli on cli.CODIGO = ir.CUSTOMER_ID
left join viavante.CATALOGO cat on cat.CNPJ_CPF = cli.CNPJ_CPF--clientes

left join viavante.REPRESENTANTE r on r.CODIGO = irs.ID_UNITY
left join viavante.CATALOGO cata on cata.CNPJ_CPF = r.CNPJ_CPF
left join viavante.contato ctt ON ctt.cnpj_cpf = cata.cnpj_cpf--unidades

left join viavante.INSURANCE_STATUS iss on iss.ID = irs.ID_STATUS--status
left join viavante.INSURANCE_STATUS issc on issc.ID = irsc.ID_STATUS

left join viavante.PRICE_LIST_BENEFITS plb on plb.ID = irsc.ID_PRICE_LIST
left join viavante.TYPE_CATEGORY tc on tc.ID = plb.ID_TYPE_CATEGORY
left join viavante.CATEGORY c on c.ID = tc.ID_CATEGORY
left join viavante.BENEFITS b on b.ID = c.ID_BENEFITS --benefícios

left join viavante.INSURANCE_VEHICLE iv on iv.ID = irsc.ID_VEHICLE
left join viavante.TIPO_VEICULO tv on tv.CODIGO = iv.CODE_TYPE_VEHICLE
left join viavante.insurance_trailer it ON it.id = irsc.id_trailer
left join viavante.insurance_trailer itt ON itt.id = irsct.id_trailer --placas

left join  viavante.insurance_people ip ON ip.id = irsc.id_people --motoristas

where iss.description = 'ATIVO'
and issc.description = 'ATIVO'



