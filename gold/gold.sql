-- Primera carga. Volver a correr esto renumera los id.

CREATE SCHEMA IF NOT EXISTS compras_estado.gold;

CREATE OR REPLACE TABLE compras_estado.gold.dim_saf (
  saf_id BIGINT,
  Nro_SAF INT,
  Descripcion_SAF STRING
) USING DELTA;

INSERT OVERWRITE compras_estado.gold.dim_saf
WITH saf AS (
  SELECT Nro_SAF, Descripcion_SAF
  FROM compras_estado.silver.adjudicaciones
  UNION
  SELECT Nro_SAF, Descripcion_SAF
  FROM compras_estado.silver.convocatorias
)
SELECT
  ROW_NUMBER() OVER (ORDER BY Nro_SAF, Descripcion_SAF) AS saf_id,
  Nro_SAF,
  Descripcion_SAF
FROM saf;

CREATE OR REPLACE TABLE compras_estado.gold.dim_uoc (
  uoc_id BIGINT,
  Nro_UOC INT,
  Descripcion_UOC STRING
) USING DELTA;

INSERT OVERWRITE compras_estado.gold.dim_uoc
WITH uoc AS (
  SELECT Nro_UOC, Descripcion_UOC
  FROM compras_estado.silver.convocatorias
  UNION
  SELECT Nro_UOC, Descripcion_UOC
  FROM compras_estado.silver.adjudicaciones
)
SELECT
  ROW_NUMBER() OVER (ORDER BY Nro_UOC, Descripcion_UOC) AS uoc_id,
  Nro_UOC,
  Descripcion_UOC
FROM uoc;

CREATE OR REPLACE TABLE compras_estado.gold.dim_compras (
  compra_id BIGINT,
  Numero_Proceso STRING,
  saf_id BIGINT,
  uoc_id BIGINT,
  Tipo_de_Procedimiento STRING,
  Modalidad STRING,
  Apartado_Directa STRING,
  Ejercicio INT,
  Fecha_de_Publicacion TIMESTAMP,
  Fecha_de_Apertura TIMESTAMP,
  Etapa STRING,
  Alcance STRING,
  Nombre_del_Proceso STRING,
  Objeto_del_Proceso STRING,
  Monto_Estimado DECIMAL(15, 2),
  Tipo_de_Operacion STRING
) USING DELTA;

INSERT OVERWRITE compras_estado.gold.dim_compras
SELECT
  ROW_NUMBER() OVER (ORDER BY sc.Numero_Proceso) AS compra_id,
  sc.Numero_Proceso,
  s.saf_id,
  u.uoc_id,
  sc.Tipo_de_Procedimiento,
  COALESCE(sc.Modalidad, 'Sin especificar'),
  sc.Apartado_Directa,
  sc.Ejercicio,
  sc.Fecha_de_Publicacion,
  sc.Fecha_de_Apertura,
  COALESCE(sc.Etapa, 'Sin especificar') AS Etapa,
  sc.Alcance,
  sc.Nombre_del_Proceso,
  sc.Objeto_del_Proceso,
  sc.Monto_Estimado,
  sc.Tipo_de_Operacion
FROM compras_estado.silver.convocatorias sc
LEFT JOIN compras_estado.gold.dim_saf s
  ON sc.Nro_SAF = s.Nro_SAF AND sc.Descripcion_SAF = s.Descripcion_SAF
LEFT JOIN compras_estado.gold.dim_uoc u
  ON sc.Nro_UOC = u.Nro_UOC AND sc.Descripcion_UOC = u.Descripcion_UOC;

CREATE OR REPLACE TABLE compras_estado.gold.fact_ordenes (
  orden_id BIGINT,
  compra_id BIGINT,
  saf_id BIGINT,
  uoc_id BIGINT,
  Numero_Proceso STRING,
  Documento_Contractual STRING,
  Tipo STRING,
  Unidad_Ejecutora STRING,
  Tipo_de_Procedimiento STRING,
  Modalidad STRING,
  Apartado_Directa STRING,
  Ejercicio INT,
  Fecha_de_Adjudicacion TIMESTAMP,
  Rubros STRING,
  CUIT STRING,
  Descripcion_Proveedor STRING,
  Monto DECIMAL(15, 2),
  Moneda STRING,
  Tipo_de_Operacion STRING,
  Fecha_de_perfeccionamiento_OC TIMESTAMP
) USING DELTA;

INSERT OVERWRITE compras_estado.gold.fact_ordenes
SELECT
  ROW_NUMBER() OVER (ORDER BY sa.Numero_Proceso, sa.Documento_Contractual, sa.Tipo) AS orden_id,
  dc.compra_id,
  ds.saf_id,
  du.uoc_id,
  sa.Numero_Proceso,
  sa.Documento_Contractual,
  sa.Tipo,
  sa.Unidad_Ejecutora,
  sa.Tipo_de_Procedimiento,
  sa.Modalidad,
  sa.Apartado_Directa,
  sa.Ejercicio,
  sa.Fecha_de_Adjudicacion,
  sa.Rubros,
  sa.CUIT,
  sa.Descripcion_Proveedor,
  sa.Monto,
  sa.Moneda,
  sa.Tipo_de_Operacion,
  sa.Fecha_de_perfeccionamiento_OC
FROM compras_estado.silver.adjudicaciones sa
LEFT JOIN compras_estado.gold.dim_compras dc
  ON sa.Numero_Proceso = dc.Numero_Proceso
LEFT JOIN compras_estado.gold.dim_saf ds
  ON sa.Nro_SAF = ds.Nro_SAF AND sa.Descripcion_SAF = ds.Descripcion_SAF
LEFT JOIN compras_estado.gold.dim_uoc du
  ON sa.Nro_UOC = du.Nro_UOC AND sa.Descripcion_UOC = du.Descripcion_UOC;
