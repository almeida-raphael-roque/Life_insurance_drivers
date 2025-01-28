SELECT 
cat.fantasia as unidade,
--
cata.fantasia as cliente,
irs.id as conjunto,
irsc.id as coverage,
b.description,

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

AS 'placa'

    
FROM
insurance_registration ir
LEFT JOIN insurance_reg_set irs ON irs.parent = ir.id
LEFT JOIN insurance_reg_set_coverage irsc ON irs.parent = ir.id
LEFT JOIN insurance_reg_set_cov_trailer irsct ON irsct.parent = irsc.id -- ^^joins base
LEFT JOIN representante r ON r.codigo = ir.id_unity
LEFT JOIN cliente cli ON cli.codigo = ir.customer_id
LEFT JOIN catalogo cat ON cat.cnpj_cpf = r.cnpj_cpf
LEFT JOIN catalogo cata ON cata.cnpj_cpf = cli.cnpj_cpf -- ^^joins para unidade e cliente (cata é cliente, cat é unidade)
LEFT JOIN insurance_vehicle iv ON iv.id = irsc.id_vehicle 
LEFT JOIN insurance_trailer it ON it.id = irsc.id_trailer 
LEFT JOIN insurance_trailer itt ON itt.id = irsct.id_trailer -- ^^joins para placas
LEFT JOIN price_list_benefits plb ON plb.id = irsc.id_price_list
LEFT JOIN type_category ty ON ty.id = plb.id_type_category 
LEFT JOIN category c ON c.id = ty.id_category
LEFT JOIN benefits b ON b.id = c.id_benefits -- ^^joins para puxar benefícios 