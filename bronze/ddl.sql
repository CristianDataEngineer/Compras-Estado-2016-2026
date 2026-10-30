CREATE SCHEMA IF NOT EXISTS compras_estado.bronze;

CREATE OR REPLACE TABLE compras_estado.bronze.adjudicaciones (
  Numero_Proceso STRING,
  Nro_SAF STRING,
  Descripcion_SAF STRING,
  Nro_UOC STRING,
  Descripcion_UOC STRING,
  Unidad_Ejecutora STRING,
  Tipo_de_Procedimiento STRING,
  Modalidad STRING,
  Apartado_Directa STRING,
  Ejercicio STRING,
  Fecha_de_Adjudicacion STRING,
  Rubros STRING,
  CUIT STRING,
  Descripcion_Proveedor STRING,
  Documento_Contractual STRING,
  Tipo STRING,
  Monto STRING,
  Moneda STRING,
  Tipo_de_Operacion STRING,
  Fecha_de_perfeccionamiento_OC STRING
) USING DELTA;

CREATE OR REPLACE TABLE compras_estado.bronze.convocatorias (
  Numero_Proceso STRING,
  Nro_SAF STRING,
  Descripcion_SAF STRING,
  Nro_UOC STRING,
  Descripcion_UOC STRING,
  Tipo_de_Procedimiento STRING,
  Modalidad STRING,
  Apartado_Directa STRING,
  Ejercicio STRING,
  Fecha_de_Publicacion STRING,
  Fecha_de_Apertura STRING,
  Etapa STRING,
  Alcance STRING,
  Nombre_del_Proceso STRING,
  Objeto_del_Proceso STRING,
  Monto_Estimado STRING,
  Tipo_de_Operacion STRING
) USING DELTA;
