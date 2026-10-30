# landing

El archivo como llegó. Esta capa no asigna tipos. El texto de cada columna se fija en bronze.

## adjudicaciones

Una fila es una orden de compra.

Columnas: `Numero_Proceso`, `Nro_SAF`, `Descripcion_SAF`, `Nro_UOC`, `Descripcion_UOC`, `Unidad_Ejecutora`, `Tipo_de_Procedimiento`, `Modalidad`, `Apartado_Directa`, `Ejercicio`, `Fecha_de_Adjudicacion`, `Rubros`, `CUIT`, `Descripcion_Proveedor`, `Documento_Contractual`, `Tipo`, `Monto`, `Moneda`, `Tipo_de_Operacion`, `Fecha_de_perfeccionamiento_OC`.

No se agregan columnas. No se borran filas. No se cruza con convocatorias.

## convocatorias

Una fila es un proceso de compra.

Columnas: `Numero_Proceso`, `Nro_SAF`, `Descripcion_SAF`, `Nro_UOC`, `Descripcion_UOC`, `Tipo_de_Procedimiento`, `Modalidad`, `Apartado_Directa`, `Ejercicio`, `Fecha_de_Publicacion`, `Fecha_de_Apertura`, `Etapa`, `Alcance`, `Nombre_del_Proceso`, `Objeto_del_Proceso`, `Monto_Estimado`, `Tipo_de_Operacion`.

No tiene `Unidad_Ejecutora`. No se agregan columnas. No se borran filas. No se cruza con adjudicaciones.
