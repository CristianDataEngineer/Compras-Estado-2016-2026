INSERT OVERWRITE compras_estado.silver.convocatorias
SELECT
  TRIM(Numero_Proceso) AS Numero_Proceso,
  CAST(NULLIF(TRIM(Nro_SAF), '') AS INT) AS Nro_SAF,
  NULLIF(TRIM(Descripcion_SAF), '') AS Descripcion_SAF,
  CAST(NULLIF(TRIM(Nro_UOC), '') AS INT) AS Nro_UOC,
  NULLIF(TRIM(Descripcion_UOC), '') AS Descripcion_UOC,
  NULLIF(TRIM(Tipo_de_Procedimiento), '') AS Tipo_de_Procedimiento,
  NULLIF(TRIM(Modalidad), '') AS Modalidad,
  CASE
    WHEN Tipo_de_Procedimiento = 'Contratación Directa'
      AND (Apartado_Directa IS NULL OR TRIM(Apartado_Directa) = '')
      THEN 'Sin especificar'
    WHEN Apartado_Directa IS NULL OR TRIM(Apartado_Directa) = ''
      THEN 'No aplica'
    ELSE Apartado_Directa
  END AS Apartado_Directa,
  CAST(NULLIF(TRIM(Ejercicio), '') AS INT) AS Ejercicio,
  to_timestamp(NULLIF(REPLACE(REPLACE(TRIM(Fecha_de_Publicacion), 'a.m.', 'AM'), 'p.m.', 'PM'), ''), 'dd/MM/yyyy hh:mm:ss a') AS Fecha_de_Publicacion,
  to_timestamp(NULLIF(REPLACE(REPLACE(TRIM(Fecha_de_Apertura), 'a.m.', 'AM'), 'p.m.', 'PM'), ''), 'dd/MM/yyyy hh:mm:ss a') AS Fecha_de_Apertura,
  NULLIF(TRIM(Etapa), '') AS Etapa,
  NULLIF(TRIM(Alcance), '') AS Alcance,
  NULLIF(TRIM(Nombre_del_Proceso), '') AS Nombre_del_Proceso,
  NULLIF(TRIM(Objeto_del_Proceso), '') AS Objeto_del_Proceso,
  CAST(NULLIF(REPLACE(TRIM(Monto_Estimado), ',', ''), '') AS DECIMAL(15, 2)) AS Monto_Estimado,
  NULLIF(TRIM(Tipo_de_Operacion), '') AS Tipo_de_Operacion
FROM compras_estado.bronze.convocatorias
WHERE TRIM(Numero_Proceso) IS NOT NULL
  AND TRIM(Numero_Proceso) <> '';

INSERT OVERWRITE compras_estado.silver.adjudicaciones
SELECT
  TRIM(Numero_Proceso) AS Numero_Proceso,
  CAST(NULLIF(TRIM(Nro_SAF), '') AS INT) AS Nro_SAF,
  NULLIF(TRIM(Descripcion_SAF), '') AS Descripcion_SAF,
  CAST(NULLIF(TRIM(Nro_UOC), '') AS INT) AS Nro_UOC,
  NULLIF(TRIM(Descripcion_UOC), '') AS Descripcion_UOC,
  NULLIF(TRIM(Unidad_Ejecutora), '') AS Unidad_Ejecutora,
  NULLIF(TRIM(Tipo_de_Procedimiento), '') AS Tipo_de_Procedimiento,
  NULLIF(TRIM(Modalidad), '') AS Modalidad,
  CASE
    WHEN Tipo_de_Procedimiento = 'Contratación Directa'
      AND (Apartado_Directa IS NULL OR TRIM(Apartado_Directa) = '')
      THEN 'Sin especificar'
    WHEN Apartado_Directa IS NULL OR TRIM(Apartado_Directa) = ''
      THEN 'No aplica'
    ELSE Apartado_Directa
  END AS Apartado_Directa,
  CAST(NULLIF(TRIM(Ejercicio), '') AS INT) AS Ejercicio,
  to_timestamp(NULLIF(REPLACE(REPLACE(TRIM(Fecha_de_Adjudicacion), 'a.m.', 'AM'), 'p.m.', 'PM'), ''), 'dd/MM/yyyy hh:mm:ss a') AS Fecha_de_Adjudicacion,
  NULLIF(TRIM(Rubros), '') AS Rubros,
  NULLIF(TRIM(CUIT), '') AS CUIT,
  NULLIF(TRIM(Descripcion_Proveedor), '') AS Descripcion_Proveedor,
  NULLIF(TRIM(Documento_Contractual), '') AS Documento_Contractual,
  NULLIF(TRIM(Tipo), '') AS Tipo,
  CAST(NULLIF(REPLACE(TRIM(Monto), ',', ''), '') AS DECIMAL(15, 2)) AS Monto,
  NULLIF(TRIM(Moneda), '') AS Moneda,
  NULLIF(TRIM(Tipo_de_Operacion), '') AS Tipo_de_Operacion,
  to_timestamp(NULLIF(REPLACE(REPLACE(TRIM(Fecha_de_perfeccionamiento_OC), 'a.m.', 'AM'), 'p.m.', 'PM'), ''), 'dd/MM/yyyy hh:mm:ss a') AS Fecha_de_perfeccionamiento_OC
FROM compras_estado.bronze.adjudicaciones
WHERE TRIM(Numero_Proceso) IS NOT NULL
  AND TRIM(Numero_Proceso) <> ''
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY
    TRIM(Numero_Proceso),
    NULLIF(TRIM(Documento_Contractual), ''),
    NULLIF(TRIM(Tipo), '')
  ORDER BY
    CASE
      WHEN NULLIF(TRIM(Fecha_de_Adjudicacion), '') IS NULL THEN 1
      ELSE 0
    END
) = 1;
