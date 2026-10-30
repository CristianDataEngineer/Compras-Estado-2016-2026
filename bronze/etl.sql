INSERT OVERWRITE compras_estado.bronze.adjudicaciones
SELECT
  Numero_Proceso,
  Nro_SAF,
  Descripcion_SAF,
  Nro_UOC,
  Descripcion_UOC,
  Unidad_Ejecutora,
  Tipo_de_Procedimiento,
  Modalidad,
  Apartado_Directa,
  Ejercicio,
  Fecha_de_Adjudicacion,
  Rubros,
  CUIT,
  Descripcion_Proveedor,
  Documento_Contractual,
  Tipo,
  Monto,
  Moneda,
  Tipo_de_Operacion,
  Fecha_de_perfeccionamiento_OC
FROM compras_estado.landing.adjudicaciones;

INSERT OVERWRITE compras_estado.bronze.convocatorias
SELECT
  Numero_Proceso,
  Nro_SAF,
  Descripcion_SAF,
  Nro_UOC,
  Descripcion_UOC,
  Tipo_de_Procedimiento,
  Modalidad,
  Apartado_Directa,
  Ejercicio,
  Fecha_de_Publicacion,
  Fecha_de_Apertura,
  Etapa,
  Alcance,
  Nombre_del_Proceso,
  Objeto_del_Proceso,
  Monto_Estimado,
  Tipo_de_Operacion
FROM compras_estado.landing.convocatorias;
