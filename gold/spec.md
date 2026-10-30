# gold

El esquema es una estrella. Al centro está la orden. Alrededor están la compra, el organismo y la oficina.

El id es un entero largo. En la primera carga sale de `ROW_NUMBER`, ordenado por la clave natural. No es IDENTITY y no es un hash. Volver a numerar después de que otras tablas apunten a esos id los cambia.

## dim_saf

Una fila es un par `Nro_SAF` + `Descripcion_SAF`.

| Columna | Tipo |
|---|---|
| saf_id | entero largo |
| Nro_SAF | entero |
| Descripcion_SAF | texto |

El par sale de convocatorias y de adjudicaciones. El mismo código con dos textos distintos queda en dos filas. No se elige un nombre único. El código 673 existe solo en adjudicaciones y también tiene id.

## dim_uoc

Una fila es un par `Nro_UOC` + `Descripcion_UOC`.

| Columna | Tipo |
|---|---|
| uoc_id | entero largo |
| Nro_UOC | entero |
| Descripcion_UOC | texto |

Misma regla que el organismo: las dos tablas aportan pares, y un texto parecido pero distinto es otra fila.

## dim_compras

Una fila es un proceso de compra. Sale solo de convocatorias.

| Columna | Tipo |
|---|---|
| compra_id | entero largo |
| Numero_Proceso | texto |
| saf_id | entero largo |
| uoc_id | entero largo |
| Tipo_de_Procedimiento | texto |
| Modalidad | texto |
| Apartado_Directa | texto |
| Ejercicio | entero |
| Fecha_de_Publicacion | fecha y hora |
| Fecha_de_Apertura | fecha y hora |
| Etapa | texto |
| Alcance | texto |
| Nombre_del_Proceso | texto |
| Objeto_del_Proceso | texto |
| Monto_Estimado | decimal (15, 2) |
| Tipo_de_Operacion | texto |

`compra_id` se numera por `Numero_Proceso`. `saf_id` y `uoc_id` se buscan por código y por nombre juntos. Si el código o el nombre es nulo, la compra entra igual y el id queda nulo.

`Modalidad` nula y `Etapa` nula pasan a `Sin especificar`. El texto `Sin Modalidad` se conserva. `Ejercicio` sigue siendo el año, entero. Un año vacío sigue vacío.

## fact_ordenes

Una fila es una orden de compra. Es lo que se cuenta y se suma.

| Columna | Tipo |
|---|---|
| orden_id | entero largo |
| compra_id | entero largo |
| saf_id | entero largo |
| uoc_id | entero largo |
| Numero_Proceso | texto |
| Documento_Contractual | texto |
| Tipo | texto |
| Unidad_Ejecutora | texto |
| Tipo_de_Procedimiento | texto |
| Modalidad | texto |
| Apartado_Directa | texto |
| Ejercicio | entero |
| Fecha_de_Adjudicacion | fecha y hora |
| Rubros | texto |
| CUIT | texto |
| Descripcion_Proveedor | texto |
| Monto | decimal (15, 2) |
| Moneda | texto |
| Tipo_de_Operacion | texto |
| Fecha_de_perfeccionamiento_OC | fecha y hora |

`orden_id` se numera por `Numero_Proceso`, `Documento_Contractual` y `Tipo`. `compra_id` se busca por `Numero_Proceso`.

`saf_id` y `uoc_id` son los de la orden, buscados por el código y el nombre de la orden. No se copian de la compra. El organismo puede haberse renombrado entre la publicación y la orden: la compra queda con un id y la orden con otro. Las dos se conectan por `compra_id`.

`Ejercicio` es entero. Las órdenes sin año quedan con el año vacío. `CUIT` y `Rubros` quedan como llegaron de silver. Pesos y dólares no se suman juntos.
