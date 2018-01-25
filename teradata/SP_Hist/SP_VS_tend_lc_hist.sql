REPLACE PROCEDURE d_cientificos_datos.sp_VS_tend_lc_hist(cod_mes INTEGER, cod_banco SMALLINT)
BEGIN
--------------------------------------------------------------------------------------------------------------------------------
-----------Creacion de tablas con Variables de Tendencias (Liquidacion_cuenta)----------------------
--------------------------------------------------------------------------------------------------------------------------------
DELETE FROM d_cientificos_datos.VS_tend_lc_hist WHERE cod_mes = :cod_mes AND cod_banco = :cod_banco;

--------------------------------------------------------------------------------------------------------------------------------
-----------Creacion de tablas con Variables de Tendencias (Liquidacion_cuenta)----------------------
--------------------------------------------------------------------------------------------------------------------------------
INSERT INTO d_cientificos_datos.VS_tend_lc_hist
SELECT 
A.nro_cuenta,
A.cod_mes,
A.cod_banco,
CASE WHEN (CASE WHEN (SUM(A.Intereses_Punitorios_Total)-SUM(SCH1.Intereses_Punitorios_Total ) )IS NOT NULL THEN 1  ELSE 0 END +
							CASE WHEN (SUM(SCH1.Intereses_Punitorios_Total)-SUM(SCH2.Intereses_Punitorios_Total )) IS NOT NULL THEN 1 ELSE 0 END +
								CASE WHEN (SUM(SCH2.Intereses_Punitorios_Total)-SUM(SCH3.Intereses_Punitorios_Total ) )IS NOT NULL THEN 1 ELSE 0 END +
									CASE WHEN (SUM(SCH3.Intereses_Punitorios_Total)-SUM(SCH4.Intereses_Punitorios_Total )) IS NOT NULL THEN 1  ELSE 0 END )=0 THEN NULL ELSE									
((CASE WHEN SUM(SCH1.Intereses_Punitorios_Total) >0 THEN  ((SUM(A.Intereses_Punitorios_Total)-SUM(SCH1.Intereses_Punitorios_Total))/SUM(SCH1.Intereses_Punitorios_Total )) ELSE 0 END+
	CASE WHEN SUM(SCH2.Intereses_Punitorios_Total) >0 THEN ((SUM(SCH1.Intereses_Punitorios_Total)-SUM(SCH2.Intereses_Punitorios_Total))/SUM(SCH2.Intereses_Punitorios_Total )) ELSE 0 END+
		CASE WHEN SUM(SCH3.Intereses_Punitorios_Total) >0 THEN ((SUM(SCH2.Intereses_Punitorios_Total)-SUM(SCH3.Intereses_Punitorios_Total))/SUM(SCH3.Intereses_Punitorios_Total )) ELSE 0 END+
			CASE WHEN SUM(SCH4.Intereses_Punitorios_Total) >0 THEN ((SUM(SCH3.Intereses_Punitorios_Total)-SUM(SCH4.Intereses_Punitorios_Total))/SUM(SCH4.Intereses_Punitorios_Total )) ELSE 0 END)/			  
			   (CASE WHEN SUM(A.Intereses_Punitorios_Total)-SUM(SCH1.Intereses_Punitorios_Total ) IS NOT NULL THEN 1  ELSE 0 END +
					CASE WHEN SUM(SCH1.Intereses_Punitorios_Total)-SUM(SCH2.Intereses_Punitorios_Total ) IS NOT NULL THEN 1  ELSE 0 END +
						CASE WHEN SUM(SCH2.Intereses_Punitorios_Total)-SUM(SCH3.Intereses_Punitorios_Total ) IS NOT NULL THEN 1  ELSE 0 END +
							CASE WHEN SUM(SCH3.Intereses_Punitorios_Total)-SUM(SCH4.Intereses_Punitorios_Total ) IS NOT NULL THEN 1  ELSE 0 END )) END AS Prom_Dif_IntPun,

CASE WHEN (CASE WHEN (SUM(A.Monto_IVA_Pesos)-SUM(SCH1.Monto_IVA_Pesos )) IS NOT NULL THEN 1  ELSE 0 END +
							  CASE WHEN (SUM(SCH1.Monto_IVA_Pesos)-SUM(SCH2.Monto_IVA_Pesos )) IS NOT NULL THEN 1  ELSE 0 END +
								CASE WHEN (SUM(SCH2.Monto_IVA_Pesos)-SUM(SCH3.Monto_IVA_Pesos )) IS NOT NULL THEN 1  ELSE 0 END +
									CASE WHEN (SUM(SCH3.Monto_IVA_Pesos)-SUM(SCH4.Monto_IVA_Pesos )) IS NOT NULL THEN 1  ELSE 0 END)=0 THEN NULL ELSE		
(CASE WHEN SUM(SCH1.Monto_IVA_Pesos) >0 THEN ((SUM(A.Monto_IVA_Pesos)-SUM(SCH1.Monto_IVA_Pesos))/SUM(SCH1.Monto_IVA_Pesos ) )ELSE 0 END +
	CASE WHEN SUM(SCH2.Monto_IVA_Pesos) >0 THEN ((SUM(SCH1.Monto_IVA_Pesos)-SUM(SCH2.Monto_IVA_Pesos))/SUM(SCH2.Monto_IVA_Pesos )) ELSE 0 END+
		CASE WHEN SUM(SCH3.Monto_IVA_Pesos) >0  THEN ((SUM(SCH2.Monto_IVA_Pesos)-SUM(SCH3.Monto_IVA_Pesos))/SUM(SCH3.Monto_IVA_Pesos) ) ELSE 0 END+ 
			CASE WHEN SUM(SCH4.Monto_IVA_Pesos) >0 THEN ((SUM(SCH3.Monto_IVA_Pesos)-SUM(SCH4.Monto_IVA_Pesos))/SUM(SCH4.Monto_IVA_Pesos )) ELSE 0 END) /
			(CASE WHEN SUM(A.Monto_IVA_Pesos)-SUM(SCH1.Monto_IVA_Pesos ) IS NOT NULL THEN 1  ELSE 0 END +
				CASE WHEN SUM(SCH1.Monto_IVA_Pesos)-SUM(SCH2.Monto_IVA_Pesos ) IS NOT NULL THEN 1  ELSE 0 END +
					CASE WHEN SUM(SCH2.Monto_IVA_Pesos)-SUM(SCH3.Monto_IVA_Pesos ) IS NOT NULL THEN 1  ELSE 0 END +
						CASE WHEN SUM(SCH3.Monto_IVA_Pesos)-SUM(SCH4.Monto_IVA_Pesos ) IS NOT NULL THEN 1  ELSE 0 END) END AS Prom_Dif_IVA,

CASE WHEN (CASE WHEN (SUM(A.Intereses_Financiacion_Pesos)-SUM(SCH1.Intereses_Financiacion_Pesos )) IS NOT NULL THEN 1  ELSE 0 END +
							CASE WHEN (SUM(SCH1.Intereses_Financiacion_Pesos)-SUM(SCH2.Intereses_Financiacion_Pesos ) )IS NOT NULL THEN 1  ELSE 0 END +
								CASE WHEN (SUM(SCH2.Intereses_Financiacion_Pesos)-SUM(SCH3.Intereses_Financiacion_Pesos ) )IS NOT NULL THEN 1  ELSE 0 END +
									CASE WHEN (SUM(SCH3.Intereses_Financiacion_Pesos)-SUM(SCH4.Intereses_Financiacion_Pesos ) )IS NOT NULL THEN 1  ELSE 0 END)=0 THEN NULL ELSE 			
(CASE WHEN SUM(SCH1.Intereses_Financiacion_Pesos) >0 THEN ((SUM(A.Intereses_Financiacion_Pesos)-SUM(SCH1.Intereses_Financiacion_Pesos))/SUM(SCH1.Intereses_Financiacion_Pesos ) )ELSE 0 END +
	CASE WHEN SUM(SCH2.Intereses_Financiacion_Pesos) >0 THEN  ((SUM(SCH1.Intereses_Financiacion_Pesos)-SUM(SCH2.Intereses_Financiacion_Pesos))/SUM(SCH2.Intereses_Financiacion_Pesos) ) ELSE 0 END+
		CASE WHEN SUM(SCH3.Intereses_Financiacion_Pesos) >0 THEN  ((SUM(SCH2.Intereses_Financiacion_Pesos)-SUM(SCH3.Intereses_Financiacion_Pesos))/SUM(SCH3.Intereses_Financiacion_Pesos) ) ELSE 0 END+
			CASE WHEN SUM(SCH4.Intereses_Financiacion_Pesos) >0 THEN  ((SUM(SCH3.Intereses_Financiacion_Pesos)-SUM(SCH4.Intereses_Financiacion_Pesos))/SUM(SCH4.Intereses_Financiacion_Pesos) ) ELSE 0 END)/
			(CASE WHEN SUM(A.Intereses_Financiacion_Pesos)-SUM(SCH1.Intereses_Financiacion_Pesos ) IS NOT NULL THEN 1  ELSE 0 END +
				CASE WHEN SUM(SCH1.Intereses_Financiacion_Pesos)-SUM(SCH2.Intereses_Financiacion_Pesos ) IS NOT NULL THEN 1  ELSE 0 END +
					CASE WHEN SUM(SCH2.Intereses_Financiacion_Pesos)-SUM(SCH3.Intereses_Financiacion_Pesos ) IS NOT NULL THEN 1  ELSE 0 END +
						CASE WHEN SUM(SCH3.Intereses_Financiacion_Pesos)-SUM(SCH4.Intereses_Financiacion_Pesos ) IS NOT NULL THEN 1  ELSE 0 END) END   AS Prom_Dif_IntFin								

FROM d_cientificos_datos.VS_aux_cta_hist AS A

LEFT JOIN p_views.liquidacion_cuenta AS SCH1
	ON A.nro_cuenta=SCH1.nro_cuenta
	AND (SCH1.ano*100+SCH1.mes)=CASE WHEN A.mes=1 THEN A.cod_mes-89 ELSE A.cod_mes-1 END
	
LEFT JOIN p_views.liquidacion_cuenta AS SCH2
	ON SCH1.nro_cuenta=SCH2.nro_cuenta
	AND (SCH2.ano*100+SCH2.mes)= CASE WHEN SCH1.mes=1 THEN (SCH1.ano*100+SCH1.mes)-89 ELSE (SCH1.ano*100+SCH1.mes)-1 END
	
LEFT JOIN p_views.liquidacion_cuenta AS SCH3
	ON SCH2.nro_cuenta=SCH3.nro_cuenta
	AND (SCH3.ano*100+SCH3.mes) =CASE WHEN SCH2.mes=1 THEN (SCH2.ano*100+SCH2.mes)-89 ELSE (SCH2.ano*100+SCH2.mes)-1 END
	
LEFT JOIN p_views.liquidacion_cuenta AS SCH4
	ON SCH3.nro_cuenta=SCH4.nro_cuenta
	AND (SCH4.ano*100+SCH4.mes)= CASE WHEN SCH3.mes=1 THEN (SCH3.ano*100+SCH3.mes)-89 ELSE (SCH3.ano*100+SCH3.mes)-1 END
       
       
 WHERE A.cod_mes = :cod_mes AND A.cod_banco = :cod_banco 

GROUP BY 1,2,3;


COLLECT STAT ON d_cientificos_datos.VS_tend_lc_hist COLUMN Nro_Cuenta;
COLLECT STAT ON d_cientificos_datos.VS_tend_lc_hist COLUMN Prom_Dif_IntFin;
COLLECT STAT ON d_cientificos_datos.VS_tend_lc_hist COLUMN Prom_Dif_IntPun;
COLLECT STAT ON d_cientificos_datos.VS_tend_lc_hist COLUMN Prom_Dif_IVA;
COLLECT STAT ON d_cientificos_datos.VS_tend_lc_hist INDEX (Nro_Cuenta);
COLLECT STAT ON d_cientificos_datos.VS_tend_lc_hist INDEX idx_cuenta_mes;


END;

