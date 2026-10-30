CREATE SCHEMA IF NOT EXISTS compras_estado.silver;

CREATE OR REPLACE TABLE compras_estado.silver.convocatorias (
  Numero_Proceso STRING,
  Nro_SAF INT,
  Descripcion_SAF STRING,
  Nro_UOC INT,
  Descripcion_UOC STRING,
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

CREATE OR REPLACE TABLE compras_estado.silver.adjudicaciones (
  Numero_Proceso STRING,
  Nro_SAF INT,
  Descripcion_SAF STRING,
  Nro_UOC INT,
  Descripcion_UOC STRING,
  Unidad_Ejecutora STRING,
  Tipo_de_Procedimiento STRING,
  Modalidad STRING,
  Apartado_Directa STRING,
  Ejercicio INT,
  Fecha_de_Adjudicacion TIMESTAMP,
  Rubros STRING,
  CUIT STRING,
  Descripcion_Proveedor STRING,
  Documento_Contractual STRING,
  Tipo STRING,
  Monto DECIMAL(15, 2),
  Moneda STRING,
  Tipo_de_Operacion STRING,
  Fecha_de_perfeccionamiento_OC TIMESTAMP
) USING DELTA;
