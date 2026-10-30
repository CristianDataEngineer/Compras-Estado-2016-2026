CREATE SCHEMA IF NOT EXISTS compras_estado.semantic;

CREATE OR REPLACE VIEW compras_estado.semantic.ordenes AS
SELECT
  f.orden_id,
  f.compra_id,
  f.Documento_Contractual,
  f.Tipo,
  f.Monto,
  f.Moneda,
  f.Ejercicio,
  f.CUIT,
  f.Descripcion_Proveedor,
  f.Rubros,
  f.Fecha_de_Adjudicacion,
  c.Numero_Proceso,
  c.Nombre_del_Proceso,
  c.Monto_Estimado,
  so.Nro_SAF AS Nro_SAF_orden,
  so.Descripcion_SAF AS Descripcion_SAF_orden,
  sc.Nro_SAF AS Nro_SAF_compra,
  sc.Descripcion_SAF AS Descripcion_SAF_compra,
  uo.Nro_UOC AS Nro_UOC_orden,
  uo.Descripcion_UOC AS Descripcion_UOC_orden,
  uc.Nro_UOC AS Nro_UOC_compra,
  uc.Descripcion_UOC AS Descripcion_UOC_compra
FROM compras_estado.gold.fact_ordenes f
LEFT JOIN compras_estado.gold.dim_compras c
  ON f.compra_id = c.compra_id
LEFT JOIN compras_estado.gold.dim_saf so
  ON f.saf_id = so.saf_id
LEFT JOIN compras_estado.gold.dim_saf sc
  ON c.saf_id = sc.saf_id
LEFT JOIN compras_estado.gold.dim_uoc uo
  ON f.uoc_id = uo.uoc_id
LEFT JOIN compras_estado.gold.dim_uoc uc
  ON c.uoc_id = uc.uoc_id;

CREATE OR REPLACE VIEW compras_estado.semantic.monto_por_proveedor_anio AS
SELECT
  CUIT,
  Descripcion_Proveedor,
  Ejercicio,
  Moneda,
  SUM(Monto) AS monto_total,
  COUNT(*) AS ordenes
FROM compras_estado.semantic.ordenes
GROUP BY CUIT, Descripcion_Proveedor, Ejercicio, Moneda;

CREATE OR REPLACE VIEW compras_estado.semantic.rubros AS
SELECT
  rubro,
  COUNT(DISTINCT orden_id) AS ordenes
FROM (
  SELECT
    orden_id,
    TRIM(rubro) AS rubro
  FROM compras_estado.semantic.ordenes
  LATERAL VIEW EXPLODE(SPLIT(Rubros, ';')) AS rubro
)
WHERE rubro <> ''
GROUP BY rubro;

CREATE OR REPLACE VIEW compras_estado.semantic.organismo AS
SELECT
  Descripcion_SAF_orden,
  Moneda,
  COUNT(*) AS ordenes,
  SUM(Monto) AS monto_total
FROM compras_estado.semantic.ordenes
GROUP BY Descripcion_SAF_orden, Moneda;

CREATE OR REPLACE VIEW compras_estado.semantic.oficina AS
SELECT
  Descripcion_UOC_orden,
  Moneda,
  COUNT(*) AS ordenes,
  SUM(Monto) AS monto_total
FROM compras_estado.semantic.ordenes
GROUP BY Descripcion_UOC_orden, Moneda;

CREATE OR REPLACE VIEW compras_estado.semantic.total_por_anio AS
SELECT
  Ejercicio,
  Moneda,
  COUNT(*) AS ordenes,
  SUM(Monto) AS monto_total
FROM compras_estado.semantic.ordenes
GROUP BY Ejercicio, Moneda;

CREATE OR REPLACE VIEW compras_estado.semantic.estimado_adjudicado AS
SELECT
  compra_id,
  Numero_Proceso,
  Nombre_del_Proceso,
  Monto_Estimado,
  Moneda,
  SUM(Monto) AS monto_adjudicado,
  COUNT(*) AS ordenes
FROM compras_estado.semantic.ordenes
WHERE compra_id IS NOT NULL
GROUP BY compra_id, Numero_Proceso, Nombre_del_Proceso, Monto_Estimado, Moneda;
