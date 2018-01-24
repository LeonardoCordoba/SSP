REPLACE PROCEDURE d_cientificos_datos.sp_VS_input_modelo_hist(cod_mes SMALLINT, cod_banco SMALLINT)
BEGIN
	
-- Esta query arma la tabla final que va a emplear el modelo
DELETE FROM d_cientificos_datos.VS_input_modelo_hist;
INSERT INTO d_cientificos_datos.VS_input_modelo_hist
SELECT a.*,
Prom_morosos_30_AA ,
prom_dif_morosos_30 ,
Prom_Dif_IntPun,
Prom_Dif_IVA ,
Prom_Dif_IntFin , 
Prom_Dif_PMI_30,
Prom_Dif_ScoFinan
FROM
D_CIENTIFICOS_DATOS.VS_aux_cta_hist a
LEFT JOIN
D_CIENTIFICOS_DATOS.VS_tend_lc_hist b
ON 
a.nro_cuenta = b.nro_cuenta
AND
a.cod_mes = b.cod_mes
LEFT JOIN
D_CIENTIFICOS_DATOS.VS_tend_sc_hist c
ON 
a.nro_cuenta = c.nro_cuenta
AND
a.cod_mes = c.cod_mes
LEFT JOIN
D_CIENTIFICOS_DATOS.VS_var_bancos_hist d
ON 
a.nro_cuenta = d.nro_cuenta
AND
a.cod_mes = d.cod_mes
WHERE 
a.cod_banco = :cod_banco
AND
a.cod_mes = :cod_mes;

COLLECT STAT ON d_cientificos_datos.VS_input_modelo_hist INDEX ( Cod_Mes ,Nro_Cuenta );



END;
