SELECT 
'Segtruck' as cooperativa,
cat.fantasia as Unidade,
cata.fantasia as Cliente,
irs.id as Conjunto,
irsc.id as Coverage,
b.description as Beneficio,

CASE 
WHEN TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%0KM%' 

   OR TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%ZERO%'

   OR TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%NOVO%'    
    
THEN 'SEM PLACA'

WHEN LENGTH(
    TRIM(
        TRANSLATE(
            COALESCE(iv.board,it.board,itt.board), ',/. -',''
        )
    )
) != 7 THEN 'DESPADRONIZADO' 

ELSE
    TRIM(
     TRANSLATE(
            COALESCE(iv.board,it.board,itt.board), ',/. -',''
    )
)

END AS "Placa",

CASE 
WHEN irsc.id_driver IS NOT NULL THEN ip.name
ELSE NULL
END AS "Motorista",
ctt.e_mail

FROM
silver.insurance_registration ir
LEFT JOIN silver.insurance_reg_set irs ON irs.parent = ir.id
LEFT JOIN silver.insurance_reg_set_coverage irsc ON irsc.parent = ir.id
LEFT JOIN silver.insurance_reg_set_cov_trailer irsct ON irsct.parent = irsc.id -- ^^joins base
LEFT JOIN silver.insurance_status ins ON ins.id = irs.id_status --join de status no conjunto
LEFT JOIN silver.insurance_status insc ON insc.id = irsc.id_status --join de status no produto (coverage)
LEFT JOIN silver.representante r ON r.codigo = irs.id_unity
LEFT JOIN silver.catalogo cat ON cat.cnpj_cpf = r.cnpj_cpf

LEFT JOIN silver.cliente cli ON cli.codigo = ir.customer_id
LEFT JOIN silver.catalogo cata ON cata.cnpj_cpf = cli.cnpj_cpf -- ^^joins para unidade e cliente (cata é cliente, cat é unidade)

LEFT JOIN silver.contato ctt ON ctt.cnpj_cpf = cat.cnpj_cpf


LEFT JOIN silver.insurance_vehicle iv ON iv.id = irsc.id_vehicle 
LEFT JOIN silver.insurance_trailer it ON it.id = irsc.id_trailer 
LEFT JOIN silver.insurance_trailer itt ON itt.id = irsct.id_trailer -- ^^joins para placas

LEFT JOIN silver.price_list_benefits plb ON plb.id = irsc.id_price_list
LEFT JOIN silver.type_category ty ON ty.id = plb.id_type_category 
LEFT JOIN silver.category c ON c.id = ty.id_category
LEFT JOIN silver.benefits b ON b.id = c.id_benefits -- ^^joins para puxar beneficios
LEFT JOIN silver.insurance_people ip ON ip.id = irsc.id_people --join para puxar posteriormente apenas motoristas

WHERE ins.id = 7
AND insc.id = 11

-------------------------------------------------------------------------------
UNION ALL
-------------------------------------------------------------------------------


SELECT 
'Stcoop' as cooperativa,
cat.fantasia as Unidade,
cata.fantasia as Cliente,
irs.id as Conjunto,
irsc.id as Coverage,
b.description as Beneficio,

CASE 
WHEN TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%0KM%' 

   OR TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%ZERO%'

   OR TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%NOVO%'    
    
THEN 'SEM PLACA'

WHEN LENGTH(
    TRIM(
        TRANSLATE(
            COALESCE(iv.board,it.board,itt.board), ',/. -',''
        )
    )
) != 7 THEN 'DESPADRONIZADO' 

ELSE
    TRIM(
     TRANSLATE(
            COALESCE(iv.board,it.board,itt.board), ',/. -',''
    )
)

END AS "Placa",

CASE 
WHEN id_driver IS NOT NULL THEN ip.name
ELSE NULL
END AS "Motorista",
ctt.e_mail

FROM
stcoop.insurance_registration ir
LEFT JOIN stcoop.insurance_reg_set irs ON irs.parent = ir.id
LEFT JOIN stcoop.insurance_reg_set_coverage irsc ON irsc.parent = ir.id
LEFT JOIN stcoop.insurance_reg_set_cov_trailer irsct ON irsct.parent = irsc.id -- ^^joins base
LEFT JOIN stcoop.insurance_status ins ON ins.id = irs.id_status --join de status no conjunto
LEFT JOIN stcoop.insurance_status insc ON insc.id = irsc.id_status --join de status no produto (coverage)
LEFT JOIN stcoop.representante r ON r.codigo = irs.id_unity
LEFT JOIN stcoop.cliente cli ON cli.codigo = ir.customer_id
LEFT JOIN stcoop.catalogo cat ON cat.cnpj_cpf = r.cnpj_cpf
LEFT JOIN stcoop.contato ctt ON ctt.cnpj_cpf = cat.cnpj_cpf
LEFT JOIN stcoop.catalogo cata ON cata.cnpj_cpf = cli.cnpj_cpf -- ^^joins para unidade e cliente (cata é cliente, cat é unidade)
LEFT JOIN stcoop.insurance_vehicle iv ON iv.id = irsc.id_vehicle 
LEFT JOIN stcoop.insurance_trailer it ON it.id = irsc.id_trailer 
LEFT JOIN stcoop.insurance_trailer itt ON itt.id = irsct.id_trailer -- ^^joins para placas
LEFT JOIN stcoop.price_list_benefits plb ON plb.id = irsc.id_price_list
LEFT JOIN stcoop.type_category ty ON ty.id = plb.id_type_category 
LEFT JOIN stcoop.category c ON c.id = ty.id_category
LEFT JOIN stcoop.benefits b ON b.id = c.id_benefits -- ^^joins para puxar beneficios
LEFT JOIN stcoop.insurance_people ip ON ip.id = irsc.id_people --join para puxar posteriormente apenas motoristas

WHERE ins.id = 7
AND insc.id = 11
-------------------------------------------------------------------------------
UNION ALL
-------------------------------------------------------------------------------


SELECT 
'Viavante' as cooperativa,
cat.fantasia as Unidade,
cata.fantasia as Cliente,
irs.id as Conjunto,
irsc.id as Coverage,
b.description as Beneficio,

CASE 
WHEN TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%0KM%' 

   OR TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%ZERO%'

   OR TRANSLATE(
        COALESCE(iv.board,it.board,itt.board), ',/. -',''
    ) LIKE '%NOVO%'    
    
THEN 'SEM PLACA'

WHEN LENGTH(
    TRIM(
        TRANSLATE(
            COALESCE(iv.board,it.board,itt.board), ',/. -',''
        )
    )
) != 7 THEN 'DESPADRONIZADO' 

ELSE
    TRIM(
     TRANSLATE(
            COALESCE(iv.board,it.board,itt.board), ',/. -',''
    )
)

END AS "Placa",

CASE 
WHEN id_driver IS NOT NULL THEN ip.name
ELSE NULL
END AS "Motorista",
ctt.e_mail

FROM
viavante.insurance_registration ir
LEFT JOIN viavante.insurance_reg_set irs ON irs.parent = ir.id
LEFT JOIN viavante.insurance_reg_set_coverage irsc ON irsc.parent = ir.id
LEFT JOIN viavante.insurance_reg_set_cov_trailer irsct ON irsct.parent = irsc.id -- ^^joins base
LEFT JOIN viavante.insurance_status ins ON ins.id = irs.id_status --join de status no conjunto
LEFT JOIN viavante.insurance_status insc ON insc.id = irsc.id_status --join de status no produto (coverage)
LEFT JOIN viavante.representante r ON r.codigo = irs.id_unity
LEFT JOIN viavante.cliente cli ON cli.codigo = ir.customer_id
LEFT JOIN viavante.catalogo cat ON cat.cnpj_cpf = r.cnpj_cpf
LEFT JOIN viavante.contato ctt ON ctt.cnpj_cpf = cat.cnpj_cpf
LEFT JOIN viavante.catalogo cata ON cata.cnpj_cpf = cli.cnpj_cpf -- ^^joins para unidade e cliente (cata é cliente, cat é unidade)
LEFT JOIN viavante.insurance_vehicle iv ON iv.id = irsc.id_vehicle 
LEFT JOIN viavante.insurance_trailer it ON it.id = irsc.id_trailer 
LEFT JOIN viavante.insurance_trailer itt ON itt.id = irsct.id_trailer -- ^^joins para placas
LEFT JOIN viavante.price_list_benefits plb ON plb.id = irsc.id_price_list
LEFT JOIN viavante.type_category ty ON ty.id = plb.id_type_category 
LEFT JOIN viavante.category c ON c.id = ty.id_category
LEFT JOIN viavante.benefits b ON b.id = c.id_benefits -- ^^joins para puxar beneficios
LEFT JOIN viavante.insurance_people ip ON ip.id = irsc.id_people --join para puxar posteriormente apenas motoristas


WHERE ins.id = 7
AND insc.id = 11

