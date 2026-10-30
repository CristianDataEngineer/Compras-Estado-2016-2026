CREATE SCHEMA IF NOT EXISTS compras_estado.gold;

CREATE OR REPLACE TABLE compras_estado.gold.dim_saf (
  saf_id BIGINT,
  Nro_SAF INT,
  Descripcion_SAF STRING
) USING DELTA;

CREATE OR REPLACE TABLE compras_estado.gold.dim_uoc (
  uoc_id BIGINT,
  Nro_UOC INT,
  Descripcion_UOC STRING
) USING DELTA;

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
